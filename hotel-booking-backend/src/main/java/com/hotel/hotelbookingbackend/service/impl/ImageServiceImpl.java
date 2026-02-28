package com.hotel.hotelbookingbackend.service.impl;

import com.hotel.hotelbookingbackend.entity.Image;
import com.hotel.hotelbookingbackend.entity.RoomType;
import com.hotel.hotelbookingbackend.repository.ImageRepository;
import com.hotel.hotelbookingbackend.repository.RoomTypeRepository;
import com.hotel.hotelbookingbackend.service.ImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.Normalizer;
import java.util.*;
import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
public class ImageServiceImpl implements ImageService {

    private final ImageRepository imageRepository;
    private final RoomTypeRepository roomTypeRepository;

    @Value("${upload.path:uploads}")
    private String UPLOAD_DIR;

    private static final String DEFAULT_EXTENSION = ".jpg";

    // ═══════════════════════════════════════════════════════════
    // HELPER: CONVERT TO CAMEL CASE
    // ═══════════════════════════════════════════════════════════

    private String toCamelCase(String input) {
        if (input == null || input.isEmpty()) {
            return "";
        }

        String normalized = Normalizer.normalize(input, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        String withoutAccents = pattern.matcher(normalized).replaceAll("");
        String cleaned = withoutAccents.replaceAll("[^a-zA-Z0-9\\s]", " ");
        String[] words = cleaned.trim().split("\\s+");
        StringBuilder camelCase = new StringBuilder();

        for (int i = 0; i < words.length; i++) {
            String word = words[i].toLowerCase();
            if (i == 0) {
                camelCase.append(word);
            } else {
                camelCase.append(word.substring(0, 1).toUpperCase())
                        .append(word.substring(1));
            }
        }

        return camelCase.toString();
    }

    // ═══════════════════════════════════════════════════════════
    // UPLOAD TEMP IMAGE
    // ═══════════════════════════════════════════════════════════

    @Override
    public String uploadTempImage(MultipartFile file) throws IOException {
        validateImageFile(file);

        // ✅ FIX: Use UPLOAD_DIR as base path
        Path tempDirPath = Paths.get(UPLOAD_DIR, "temp");
        Files.createDirectories(tempDirPath);

        System.out.println(">>> Upload - Temp directory: " + tempDirPath.toAbsolutePath());

        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String extension = getFileExtension(originalFilename);
        String uniqueFilename = UUID.randomUUID() + extension;

        // Save file
        Path filePath = tempDirPath.resolve(uniqueFilename);
        Files.copy(file.getInputStream(), filePath);

        System.out.println(">>> Upload - Temp file saved: " + filePath.toAbsolutePath());

        // Return relative path (just temp/filename, not full path)
        return "temp/" + uniqueFilename;
    }

    // ═══════════════════════════════════════════════════════════
    // MOVE TEMP IMAGES TO PERMANENT STORAGE
    // ═══════════════════════════════════════════════════════════

    @Override
    public List<Image> moveTempImages(Long hotelId, List<TempImageDTO> tempImages) throws IOException {
        List<Image> savedImages = new ArrayList<>();

        // Create hotel base folder
        String hotelFolder = "hotel" + hotelId;
        Path hotelPath = Paths.get(UPLOAD_DIR, "hotel", hotelFolder);
        Files.createDirectories(hotelPath);

        System.out.println(">>> Move - Hotel folder: " + hotelPath.toAbsolutePath());

        // Group counters by type
        Map<String, Integer> counters = new HashMap<>();

        for (TempImageDTO tempImageDTO : tempImages) {
            // ✅ FIX: Build temp file path correctly
            Path tempPath = Paths.get(UPLOAD_DIR, tempImageDTO.tempPath);

            System.out.println(">>> Move - Looking for temp file: " + tempPath.toAbsolutePath());
            System.out.println(">>> Move - File exists: " + Files.exists(tempPath));

            if (!Files.exists(tempPath)) {
                throw new IOException("Temp file not found: " + tempPath.toAbsolutePath());
            }

            String extension = getFileExtension(tempPath.getFileName().toString());
            String filenameWithoutExt;
            Path destinationPath;

            if (tempImageDTO.ownerType == Image.OwnerType.HOTEL) {
                // Hotel images
                String counterKey = "HOTEL";
                int imageIndex = counters.getOrDefault(counterKey, 0) + 1;
                counters.put(counterKey, imageIndex);

                filenameWithoutExt = hotelFolder + "_" + imageIndex;
                String physicalFileName = filenameWithoutExt + extension;
                destinationPath = hotelPath.resolve(physicalFileName);

                System.out.println(">>> Move - Hotel image destination: " + destinationPath.toAbsolutePath());

            } else if (tempImageDTO.ownerType == Image.OwnerType.ROOM_TYPE) {
                // Room type images
                RoomType roomType = roomTypeRepository.findById(tempImageDTO.ownerId)
                        .orElseThrow(() -> new IOException("Room type not found: " + tempImageDTO.ownerId));

                String roomTypeName = roomType.getName();
                String roomTypeFolderName = toCamelCase(roomTypeName);

                Path roomTypePath = hotelPath.resolve(roomTypeFolderName);
                Files.createDirectories(roomTypePath);

                System.out.println(">>> Move - Room type folder: " + roomTypePath.toAbsolutePath());

                String counterKey = "ROOM_TYPE_" + tempImageDTO.ownerId;
                int imageIndex = counters.getOrDefault(counterKey, 0) + 1;
                counters.put(counterKey, imageIndex);

                filenameWithoutExt = hotelFolder + "_" + roomTypeFolderName + imageIndex;
                String physicalFileName = filenameWithoutExt + extension;
                destinationPath = roomTypePath.resolve(physicalFileName);

                System.out.println(">>> Move - Room type image destination: " + destinationPath.toAbsolutePath());

            } else {
                throw new IOException("Unsupported owner type: " + tempImageDTO.ownerType);
            }

            // Move file from temp to destination
            Files.move(tempPath, destinationPath, StandardCopyOption.REPLACE_EXISTING);
            System.out.println(">>> Move - File moved successfully");

            // Save to database (without extension, without path)
            Image image = new Image();
            image.setOwnerType(tempImageDTO.ownerType);
            image.setOwnerId(tempImageDTO.ownerType == Image.OwnerType.HOTEL
                    ? hotelId
                    : tempImageDTO.ownerId);
            image.setImageUrl(filenameWithoutExt);
            image.setIsPrimary(tempImageDTO.isPrimary != null && tempImageDTO.isPrimary);

            savedImages.add(imageRepository.save(image));
            System.out.println(">>> Move - Image saved to DB: " + filenameWithoutExt);
        }

        return savedImages;
    }

    // ═══════════════════════════════════════════════════════════
    // GET IMAGES BY OWNER
    // ═══════════════════════════════════════════════════════════

    @Override
    public List<Image> getImagesByOwner(Image.OwnerType ownerType, Long ownerId) {
        return imageRepository.findByOwnerTypeAndOwnerId(ownerType, ownerId);
    }

    // ═══════════════════════════════════════════════════════════
    // DELETE IMAGE
    // ═══════════════════════════════════════════════════════════

    @Override
    public void deleteImage(Long imageId) throws IOException {
        Image image = imageRepository.findById(imageId)
                .orElseThrow(() -> new IOException("Image not found"));

        // Reconstruct physical path
        String physicalPath = reconstructPhysicalPath(image);
        Path filePath = Paths.get(UPLOAD_DIR, "hotel", physicalPath);

        // Delete physical file
        if (Files.exists(filePath)) {
            Files.delete(filePath);

            // If it was the last image in a room type folder, delete the folder
            if (image.getOwnerType() == Image.OwnerType.ROOM_TYPE) {
                Path parentFolder = filePath.getParent();
                if (Files.isDirectory(parentFolder)) {
                    try (var stream = Files.list(parentFolder)) {
                        if (stream.count() == 0) {
                            Files.delete(parentFolder);
                        }
                    }
                }
            }
        }

        // Delete from database
        imageRepository.delete(image);
    }

    // ═══════════════════════════════════════════════════════════
    // SET PRIMARY IMAGE
    // ═══════════════════════════════════════════════════════════

    @Override
    public void setPrimaryImage(Long imageId) {
        Image newPrimary = imageRepository.findById(imageId)
                .orElseThrow(() -> new RuntimeException("Image not found"));

        // Remove primary from all images of same owner
        List<Image> ownerImages = imageRepository.findByOwnerTypeAndOwnerId(
                newPrimary.getOwnerType(),
                newPrimary.getOwnerId()
        );

        for (Image img : ownerImages) {
            img.setIsPrimary(false);
            imageRepository.save(img);
        }

        // Set new primary
        newPrimary.setIsPrimary(true);
        imageRepository.save(newPrimary);
    }

    // ═══════════════════════════════════════════════════════════
    // HELPER: RECONSTRUCT PHYSICAL PATH
    // ═══════════════════════════════════════════════════════════

    private String reconstructPhysicalPath(Image image) throws IOException {
        String filename = image.getImageUrl();

        if (image.getOwnerType() == Image.OwnerType.HOTEL) {
            String hotelId = filename.split("_")[0];
            return hotelId + "/" + filename + DEFAULT_EXTENSION;

        } else if (image.getOwnerType() == Image.OwnerType.ROOM_TYPE) {
            RoomType roomType = roomTypeRepository.findById(image.getOwnerId())
                    .orElseThrow(() -> new IOException("Room type not found"));

            String hotelId = "hotel" + roomType.getHotel().getId();
            String roomTypeFolderName = toCamelCase(roomType.getName());

            return hotelId + "/" + roomTypeFolderName + "/" + filename + DEFAULT_EXTENSION;
        }

        throw new IOException("Unsupported owner type");
    }

    // ═══════════════════════════════════════════════════════════
    // VALIDATION & HELPERS
    // ═══════════════════════════════════════════════════════════

    private void validateImageFile(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IOException("File is empty");
        }

        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IOException("File must be an image");
        }

        List<String> allowedTypes = Arrays.asList("image/jpeg", "image/png", "image/webp");
        if (!allowedTypes.contains(contentType)) {
            throw new IOException("Only JPG, PNG, WEBP are allowed");
        }

        long maxSize = 10 * 1024 * 1024; // 10MB
        if (file.getSize() > maxSize) {
            throw new IOException("File size must not exceed 10MB");
        }
    }

    private String getFileExtension(String filename) {
        if (filename == null) return DEFAULT_EXTENSION;
        int lastDot = filename.lastIndexOf('.');
        return lastDot > 0 ? filename.substring(lastDot) : DEFAULT_EXTENSION;
    }
}