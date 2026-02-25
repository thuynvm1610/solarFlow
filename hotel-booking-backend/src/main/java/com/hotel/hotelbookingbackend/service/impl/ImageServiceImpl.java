package com.hotel.hotelbookingbackend.service.impl;

import com.hotel.hotelbookingbackend.entity.Image;
import com.hotel.hotelbookingbackend.repository.ImageRepository;
import com.hotel.hotelbookingbackend.service.ImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ImageServiceImpl implements ImageService {

    private final ImageRepository imageRepository;

    private static final String UPLOAD_DIR = "src/main/resources/static/uploads";
    private static final String TEMP_DIR = "src/main/resources/static/uploads/temp";
    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList("jpg", "jpeg", "png", "webp");
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB

    @Override
    public String uploadTempImage(MultipartFile file) throws IOException {
        validateImageFile(file);

        // Create temp directory if not exists
        Path tempPath = Paths.get(TEMP_DIR);
        Files.createDirectories(tempPath);

        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String extension = getFileExtension(originalFilename);
        String uniqueFilename = UUID.randomUUID() + extension;

        // Save file
        Path filePath = tempPath.resolve(uniqueFilename);
        Files.copy(file.getInputStream(), filePath);

        // Return relative path
        return "temp/" + uniqueFilename;
    }

    @Override
    @Transactional
    public List<Image> moveTempImages(Long hotelId, List<TempImageDTO> tempImages) throws IOException {
        List<Image> savedImages = new ArrayList<>();

        // Create hotel folder
        String hotelFolder = "hotel" + hotelId;
        Path hotelPath = Paths.get(UPLOAD_DIR, "hotel", hotelFolder);
        Files.createDirectories(hotelPath);

        // Group by owner type for numbering
        Map<String, Integer> counters = new HashMap<>();

        for (TempImageDTO tempImageDTO : tempImages) {
            // Generate counter key
            String counterKey = tempImageDTO.ownerType.name() + "_" +
                    (tempImageDTO.ownerType == Image.OwnerType.ROOM_TYPE ? tempImageDTO.ownerId : "hotel");
            int imageIndex = counters.getOrDefault(counterKey, 0) + 1;
            counters.put(counterKey, imageIndex);

            // Move from temp to hotel folder
            Path tempPath = Paths.get(UPLOAD_DIR, tempImageDTO.tempPath);
            if (!Files.exists(tempPath)) {
                throw new IOException("Temp file not found: " + tempImageDTO.tempPath);
            }

            String extension = getFileExtension(tempPath.getFileName().toString());
            String newFileName = generateFileName(hotelId, tempImageDTO.ownerType,
                    tempImageDTO.ownerId, imageIndex, extension);
            Path destinationPath = hotelPath.resolve(newFileName);

            Files.move(tempPath, destinationPath, StandardCopyOption.REPLACE_EXISTING);

            // Save to database
            Image image = new Image();
            image.setOwnerType(tempImageDTO.ownerType);
            image.setOwnerId(tempImageDTO.ownerType == Image.OwnerType.HOTEL
                    ? hotelId
                    : tempImageDTO.ownerId);
            image.setImageUrl(newFileName);
            image.setIsPrimary(tempImageDTO.isPrimary != null && tempImageDTO.isPrimary);

            savedImages.add(imageRepository.save(image));
        }

        return savedImages;
    }

    @Override
    @Transactional
    public void deleteImage(Long imageId) throws IOException {
        Image image = imageRepository.findById(imageId)
                .orElseThrow(() -> new RuntimeException("Image not found"));

        // Delete file
        Path imagePath = Paths.get(UPLOAD_DIR, "hotel",
                "hotel" + image.getOwnerId(), image.getImageUrl());
        if (Files.exists(imagePath)) {
            Files.delete(imagePath);
        }

        // Delete from database
        imageRepository.delete(image);
    }

    @Override
    public List<Image> getImagesByOwner(Image.OwnerType ownerType, Long ownerId) {
        return imageRepository.findByOwnerTypeAndOwnerId(ownerType, ownerId);
    }

    @Override
    @Transactional
    public void setPrimaryImage(Long imageId) {
        Image image = imageRepository.findById(imageId)
                .orElseThrow(() -> new RuntimeException("Image not found"));

        // Remove primary flag from all images of same owner
        List<Image> ownerImages = imageRepository.findByOwnerTypeAndOwnerId(
                image.getOwnerType(), image.getOwnerId());

        for (Image img : ownerImages) {
            img.setIsPrimary(false);
            imageRepository.save(img);
        }

        // Set this image as primary
        image.setIsPrimary(true);
        imageRepository.save(image);
    }

    // ═══════════════════════════════════════════════════════════
    // PRIVATE HELPER METHODS
    // ═══════════════════════════════════════════════════════════

    private void validateImageFile(MultipartFile file) {
        if (file.isEmpty()) {
            throw new RuntimeException("File không được để trống");
        }

        if (file.getSize() > MAX_FILE_SIZE) {
            throw new RuntimeException("File không được vượt quá 10MB");
        }

        String filename = file.getOriginalFilename();
        String extension = getFileExtension(filename).replace(".", "").toLowerCase();

        if (!ALLOWED_EXTENSIONS.contains(extension)) {
            throw new RuntimeException("Chỉ chấp nhận file jpg, jpeg, png, webp");
        }
    }

    private String getFileExtension(String filename) {
        int lastDot = filename.lastIndexOf('.');
        return lastDot > 0 ? filename.substring(lastDot) : ".jpg";
    }

    private String generateFileName(Long hotelId, Image.OwnerType ownerType,
                                    Long ownerId, int index, String extension) {
        if (ownerType == Image.OwnerType.HOTEL) {
            return "hotel" + hotelId + "_" + index + extension;
        } else {
            // For room type, we could get room type name but for simplicity use ID
            return "hotel" + hotelId + "_roomtype" + ownerId + "_" + index + extension;
        }
    }
}