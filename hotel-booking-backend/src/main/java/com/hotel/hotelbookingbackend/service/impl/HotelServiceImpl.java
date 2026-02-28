package com.hotel.hotelbookingbackend.service.impl;

import com.hotel.hotelbookingbackend.dto.*;
import com.hotel.hotelbookingbackend.entity.*;
import com.hotel.hotelbookingbackend.repository.*;
import com.hotel.hotelbookingbackend.service.HotelService;
import com.hotel.hotelbookingbackend.service.ImageService;
import com.hotel.hotelbookingbackend.specification.HotelSpecification;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.Normalizer;
import java.time.LocalTime;
import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class HotelServiceImpl implements HotelService {

    private final HotelRepository hotelRepository;
    private final RoomTypeRepository roomTypeRepository;
    private final UserRepository userRepository;
    private final AmenityRepository amenityRepository;
    private final PriceUnitRepository priceUnitRepository;
    private final HotelAmenityRepository hotelAmenityRepository;
    private final RoomRepository roomRepository;
    private final RoomTypeAmenityRepository roomTypeAmenityRepository;
    private final ImageService imageService;
    private final HotelExtraServiceRepository hotelExtraServiceRepository;

    @Override
    public Page<HotelResponseDTO> filterHotels(HotelFilterDTO filter) {
        // Build specification
        Specification<Hotel> spec = HotelSpecification.filterHotels(filter);

        // Build pageable
        Sort sort = Sort.by(
                filter.getSortDirection().equalsIgnoreCase("DESC")
                        ? Sort.Direction.DESC
                        : Sort.Direction.ASC,
                filter.getSortBy()
        );
        Pageable pageable = PageRequest.of(filter.getPage(), filter.getSize(), sort);

        // Execute query
        Page<Hotel> hotelPage = hotelRepository.findAll(spec, pageable);

        // Map to DTO
        return hotelPage.map(this::mapToResponseDTO);
    }

    @Override
    public FilterOptionsDTO getFilterOptions() {
        // Get distinct cities
        List<String> cities = hotelRepository.findDistinctCities();

        // Get hotel types
        List<Hotel.HotelType> hotelTypes = Arrays.asList(Hotel.HotelType.values());

        // Get statuses
        List<Hotel.HotelStatus> statuses = Arrays.asList(Hotel.HotelStatus.values());

        // Get distinct room type names
        List<String> roomTypeNames = roomTypeRepository.findDistinctRoomTypeNames();

        return FilterOptionsDTO.builder()
                .cities(cities)
                .hotelTypes(hotelTypes)
                .statuses(statuses)
                .roomTypeNames(roomTypeNames)
                .build();
    }

    @Override
    public HotelResponseDTO getHotelById(Long id) {
        Hotel hotel = hotelRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel not found"));
        return mapToResponseDTO(hotel);
    }

    private HotelResponseDTO mapToResponseDTO(Hotel hotel) {
        // Count rooms
        Long totalRooms = hotelRepository.countRoomsByHotelId(hotel.getId());

        // Count bookings
        Long totalBookings = hotelRepository.countBookingsByHotelId(hotel.getId());

        // Count reviews
        Long reviewCount = hotelRepository.countReviewsByHotelId(hotel.getId());

        // Get primary image
        String primaryImageUrl = hotelRepository.findPrimaryImageByHotelId(hotel.getId());

        if (primaryImageUrl == null || primaryImageUrl.isEmpty()) {
            primaryImageUrl = String.format("hotel%d_1.jpg", hotel.getId());
        }

        // Get available room types - DEDUPLICATED
        List<RoomTypeSimpleDTO> availableRoomTypes = hotel.getRooms() != null
                ? hotel.getRooms().stream()
                .collect(Collectors.groupingBy(
                        room -> room.getRoomType(),
                        Collectors.counting()
                ))
                .entrySet().stream()
                .map(entry -> RoomTypeSimpleDTO.builder()
                        .id(entry.getKey().getId())
                        .name(entry.getKey().getName())
                        .count(entry.getValue())
                        .build())
                .sorted(Comparator.comparing(RoomTypeSimpleDTO::getName))
                .collect(Collectors.toList())
                : List.of();

        return HotelResponseDTO.builder()
                .id(hotel.getId())
                .name(hotel.getName())
                .floorNumber(hotel.getFloor())
                .type(hotel.getType())
                .description(hotel.getDescription())
                .address(hotel.getAddress())
                .city(hotel.getCity())
                .starRating(hotel.getStarRating())
                .reviewRating(hotel.getReviewRating())
                .checkInTime(hotel.getCheckInTime())
                .checkOutTime(hotel.getCheckOutTime())
                .phone(hotel.getManager().getPhone())
                .email(hotel.getManager().getEmail())
                .policyText(hotel.getPolicyText())
                .checkInInstructions(hotel.getCheckInInstructions())
                .status(hotel.getStatus())
                .managerId(hotel.getManager().getId())
                .createdAt(hotel.getCreatedAt())
                .updatedAt(hotel.getUpdatedAt())
                .totalRooms(totalRooms)
                .totalBookings(totalBookings)
                .reviewCount(reviewCount)
                .primaryImageUrl(primaryImageUrl)
                .availableRoomTypes(availableRoomTypes)
                .build();
    }

    // ═══════════════════════════════════════════════════════════
    // FORM OPTIONS
    // ═══════════════════════════════════════════════════════════

    @Override
    public FormOptionsDTO getFormOptions() {
        try {
            List<Long> managerIdsWithHotel = hotelRepository.findAllManagerIds();

            List<FormOptionsDTO.ManagerDTO> managers;
            if (managerIdsWithHotel.isEmpty()) {
                // Nếu chưa có hotel nào, lấy tất cả HOTEL_MANAGER
                managers = userRepository.findByRoleIn(Arrays.asList(User.Role.HOTEL_MANAGER))
                        .stream()
                        .map(u -> FormOptionsDTO.ManagerDTO.builder()
                                .id(u.getId())
                                .fullName(u.getFullName())
                                .email(u.getEmail())
                                .build())
                        .collect(Collectors.toList());
            } else {
                // Lấy HOTEL_MANAGER chưa quản lý hotel nào
                managers = userRepository.findByRoleAndIdNotIn(User.Role.HOTEL_MANAGER, managerIdsWithHotel)
                        .stream()
                        .map(u -> FormOptionsDTO.ManagerDTO.builder()
                                .id(u.getId())
                                .fullName(u.getFullName())
                                .email(u.getEmail())
                                .build())
                        .collect(Collectors.toList());
            }

            // Get amenities by category
            List<Amenity> allAmenities = amenityRepository.findAll();

            List<FormOptionsDTO.AmenityDTO> hotelAmenities = allAmenities.stream()
                    .filter(a -> a.getCategory() == Amenity.AmenityCategory.FREE_SERVICE)
                    .map(this::mapAmenityToDTO)
                    .collect(Collectors.toList());

            List<FormOptionsDTO.AmenityDTO> extraServices = allAmenities.stream()
                    .filter(a -> a.getCategory() == Amenity.AmenityCategory.EXTRA_SERVICE)
                    .map(this::mapAmenityToDTO)
                    .collect(Collectors.toList());

            List<FormOptionsDTO.AmenityDTO> roomFeatures = allAmenities.stream()
                    .filter(a -> a.getCategory() == Amenity.AmenityCategory.ROOM_FEATURE)
                    .map(this::mapAmenityToDTO)
                    .collect(Collectors.toList());

            List<FormOptionsDTO.PriceUnitDTO> priceUnits = priceUnitRepository.findAll()
                    .stream()
                    .map(pu -> FormOptionsDTO.PriceUnitDTO.builder()
                            .id(pu.getId())
                            .name(pu.getName())
                            .code(pu.getCode())
                            .description(pu.getDescription())
                            .build())
                    .collect(Collectors.toList());

            // Hotel types
            List<FormOptionsDTO.HotelTypeOption> hotelTypes = Arrays.stream(Hotel.HotelType.values())
                    .map(type -> FormOptionsDTO.HotelTypeOption.builder()
                            .value(type.name())
                            .label(getHotelTypeLabel(type))
                            .build())
                    .collect(Collectors.toList());

            // Hotel statuses
            List<FormOptionsDTO.HotelStatusOption> hotelStatuses = Arrays.stream(Hotel.HotelStatus.values())
                    .map(status -> FormOptionsDTO.HotelStatusOption.builder()
                            .value(status.name())
                            .label(getHotelStatusLabel(status))
                            .build())
                    .collect(Collectors.toList());

            return FormOptionsDTO.builder()
                    .managers(managers)
                    .freeServices(hotelAmenities)
                    .extraServices(extraServices)
                    .roomFeatures(roomFeatures)
                    .priceUnits(priceUnits)
                    .hotelTypes(hotelTypes)
                    .hotelStatuses(hotelStatuses)
                    .build();

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error loading form options: " + e.getMessage());
        }
    }

    // ═══════════════════════════════════════════════════════════
    // CREATE HOTEL
    // ═══════════════════════════════════════════════════════════

    @Override
    @Transactional
    public Hotel createHotel(CreateHotelRequestDTO request) throws Exception {
        System.out.println("Service called");
        // 1. Validate
        validateCreateRequest(request);

        // 2. Create Hotel entity
        Hotel hotel = buildHotelEntity(request.getBasicInfo());
        hotel = hotelRepository.save(hotel);

        Map<String, RoomType> roomTypeMap = new HashMap<>();
        if (request.getCustomRoomTypes() != null && !request.getCustomRoomTypes().isEmpty()) {
            for (CreateHotelRequestDTO.RoomTypeCreateDTO rtDTO : request.getCustomRoomTypes()) {
                RoomType roomType = createRoomTypeForHotel(hotel, rtDTO);
                roomTypeMap.put(rtDTO.getTempId(), roomType);
            }
        }

        // 4. Save hotel images
        if (request.getHotelImages() != null && !request.getHotelImages().isEmpty()) {
            List<ImageService.TempImageDTO> tempImages = request.getHotelImages().stream()
                    .map(img -> new ImageService.TempImageDTO(
                            img.getTempPath(),
                            img.getIsPrimary(),
                            Image.OwnerType.HOTEL,
                            null
                    ))
                    .collect(Collectors.toList());
            imageService.moveTempImages(hotel.getId(), tempImages);
        }

        // 5. Save amenities
        if (request.getAmenities() != null) {
            saveHotelAmenitiesAndServices(hotel, request.getAmenities());
        }

        // 6. Save rooms (sử dụng roomTypeMap để map tempId → real RoomType)
        if (request.getRooms() != null && !request.getRooms().isEmpty()) {
            saveRooms(hotel, request.getRooms(), roomTypeMap);
        }

        // 7. Save room type images
        if (request.getRoomTypeImages() != null && !request.getRoomTypeImages().isEmpty()) {
            for (CreateHotelRequestDTO.RoomTypeImagesDTO rtDTO : request.getRoomTypeImages()) {
                RoomType roomType = roomTypeMap.get(rtDTO.getRoomTypeTempId());
                if (roomType != null) {
                    List<ImageService.TempImageDTO> tempImages = rtDTO.getImages().stream()
                            .map(img -> new ImageService.TempImageDTO(
                                    img.getTempPath(),
                                    img.getIsPrimary(),
                                    Image.OwnerType.ROOM_TYPE,
                                    roomType.getId()
                            ))
                            .collect(Collectors.toList());
                    imageService.moveTempImages(hotel.getId(), tempImages);
                }
            }
        }

        return hotel;
    }

    private RoomType createRoomTypeForHotel(Hotel hotel, CreateHotelRequestDTO.RoomTypeCreateDTO dto) {
        RoomType roomType = new RoomType();
        roomType.setHotel(hotel);
        roomType.setName(dto.getName());
        roomType.setDescription(dto.getDescription());
        roomType.setMaxAdults(dto.getMaxAdults());
        roomType.setMaxChildren(dto.getMaxChildren());
        roomType.setBasePrice(new BigDecimal(dto.getBasePrice()));
        roomType.setAreaM2(dto.getAreaM2());

        // Save room type first
        roomType = roomTypeRepository.save(roomType);

        // Create room_type_amenities (features)
        if (dto.getFeatureIds() != null && !dto.getFeatureIds().isEmpty()) {
            for (Long featureId : dto.getFeatureIds()) {
                Amenity feature = amenityRepository.findById(featureId)
                        .orElseThrow(() -> new RuntimeException("Không tìm thấy dịch vụ: " + featureId));

                RoomTypeAmenity rta = new RoomTypeAmenity();
                rta.setRoomType(roomType);
                rta.setAmenity(feature);
                roomTypeAmenityRepository.save(rta);
            }
        }

        return roomType;
    }

    private void saveRooms(Hotel hotel, List<CreateHotelRequestDTO.RoomDTO> roomsDTO,
                           Map<String, RoomType> roomTypeMap) {
        for (CreateHotelRequestDTO.RoomDTO roomDTO : roomsDTO) {
            RoomType roomType = roomTypeMap.get(roomDTO.getRoomTypeTempId());
            if (roomType == null) {
                throw new RuntimeException("Không tìm thấy loại phòng với tempId: " + roomDTO.getRoomTypeTempId());
            }

            Room room = new Room();
            room.setHotel(hotel);
            room.setRoomType(roomType);
            room.setRoomNumber(roomDTO.getRoomNumber());
            room.setFloor(Integer.parseInt(roomDTO.getRoomNumber().substring(0, 1)));
            room.setStatus(Room.RoomStatus.AVAILABLE);
            roomRepository.save(room);
        }
    }

    // ═══════════════════════════════════════════════════════════
    // GET DETAIL FOR EDIT
    // ═══════════════════════════════════════════════════════════

    @Override
    public HotelDetailDTO getHotelDetail(Long id) {
        Hotel hotel = hotelRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel not found"));

        // 1. Basic info
        HotelDetailDTO.HotelDetailDTOBuilder builder = HotelDetailDTO.builder()
                .id(hotel.getId())
                .name(hotel.getName())
                .description(hotel.getDescription())
                .address(hotel.getAddress())
                .city(hotel.getCity())
                .type(hotel.getType())
                .starRating(hotel.getStarRating())
                .floorNumber(hotel.getFloor())
                .checkInTime(hotel.getCheckInTime())
                .checkOutTime(hotel.getCheckOutTime())
                .checkInInstructions(hotel.getCheckInInstructions())
                .policyText(hotel.getPolicyText())
                .status(hotel.getStatus())
                .managerId(hotel.getManager().getId())
                .reviewRating(hotel.getReviewRating())
                .createdAt(hotel.getCreatedAt())
                .updatedAt(hotel.getUpdatedAt());

        // 2. Free amenities
        List<HotelAmenity> freeAmenities = hotelAmenityRepository.findByHotelId(id);
        List<Long> freeAmenityIds = freeAmenities.stream()
                .map(ha -> ha.getAmenity().getId())
                .collect(Collectors.toList());
        builder.freeAmenityIds(freeAmenityIds);

        // 3. Extra services (paid amenities)
        List<HotelExtraService> extraServices = hotelExtraServiceRepository.findByHotelId(id);
        List<HotelDetailDTO.ExtraServiceDTO> extraServiceDTOs = extraServices.stream()
                .map(es -> HotelDetailDTO.ExtraServiceDTO.builder()
                        .extraServiceId(es.getId())
                        .amenityId(es.getAmenity().getId())
                        .amenityName(es.getAmenity().getName())
                        .amenityCode(es.getAmenity().getCode())
                        .basePrice(es.getBasePrice())
                        .unitId(es.getPriceUnit().getId())
                        .unitName(es.getPriceUnit().getName())
                        .build())
                .collect(Collectors.toList());
        builder.extraServices(extraServiceDTOs);

        // 4. Rooms
        List<Room> rooms = roomRepository.findByHotelId(id);
        List<HotelDetailDTO.RoomDetailDTO> roomDTOs = rooms.stream()
                .map(room -> HotelDetailDTO.RoomDetailDTO.builder()
                        .roomId(room.getId())
                        .roomNumber(room.getRoomNumber())
                        .floorNumber(room.getFloor())
                        .roomTypeId(room.getRoomType().getId())
                        .roomTypeName(room.getRoomType().getName())
                        .status(room.getStatus().name())
                        .isBooked(isRoomBooked(room.getId()))
                        .build())
                .collect(Collectors.toList());
        builder.rooms(roomDTOs);

        // 5. Hotel images
        List<Image> hotelImages = imageService.getImagesByOwner(Image.OwnerType.HOTEL, id);
        List<HotelDetailDTO.ImageDTO> hotelImageDTOs = hotelImages.stream()
                .map(img -> HotelDetailDTO.ImageDTO.builder()
                        .imageId(img.getId())
                        .imageUrl(img.getImageUrl())
                        .fullUrl(buildImageFullUrl(img, hotel))
                        .isPrimary(img.getIsPrimary())
                        .build())
                .collect(Collectors.toList());
        builder.hotelImages(hotelImageDTOs);

        // 6. Room type images (grouped by room type)
        Map<Long, List<Image>> roomTypeImagesMap = new HashMap<>();
        List<RoomType> usedRoomTypes = rooms.stream()
                .map(Room::getRoomType)
                .distinct()
                .collect(Collectors.toList());

        for (RoomType roomType : usedRoomTypes) {
            List<Image> images = imageService.getImagesByOwner(Image.OwnerType.ROOM_TYPE, roomType.getId());
            roomTypeImagesMap.put(roomType.getId(), images);
        }

        List<HotelDetailDTO.RoomTypeImageDTO> roomTypeImageDTOs = usedRoomTypes.stream()
                .map(rt -> {
                    List<HotelDetailDTO.ImageDTO> images = roomTypeImagesMap.get(rt.getId()).stream()
                            .map(img -> HotelDetailDTO.ImageDTO.builder()
                                    .imageId(img.getId())
                                    .imageUrl(img.getImageUrl())
                                    .fullUrl(buildImageFullUrl(img, hotel))
                                    .isPrimary(img.getIsPrimary())
                                    .build())
                            .collect(Collectors.toList());

                    return HotelDetailDTO.RoomTypeImageDTO.builder()
                            .roomTypeId(rt.getId())
                            .roomTypeName(rt.getName())
                            .images(images)
                            .build();
                })
                .collect(Collectors.toList());
        builder.roomTypeImages(roomTypeImageDTOs);

        // 7. Statistics
        builder.totalRooms((long) rooms.size());
        builder.totalBookings(hotelRepository.countBookingsByHotelId(id));
        builder.reviewCount(hotelRepository.countReviewsByHotelId(id));

        return builder.build();
    }

    // Helper method
    private boolean isRoomBooked(Long roomId) {
        // Check if room has any active bookings
        // TODO: Implement based on your booking logic
        return false; // Placeholder
    }

    // ═══════════════════════════════════════════════════════════
    // UPDATE & DELETE
    // ═══════════════════════════════════════════════════════════

    @Override
    @Transactional
    public Hotel updateHotel(Long id, UpdateHotelRequestDTO request) throws Exception {
        // TODO: Implement update logic
        return null; // Placeholder
    }

    @Override
    @Transactional
    public void deleteHotel(Long id) throws Exception {
        Hotel hotel = hotelRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel not found"));

        // Delete all related images
        List<Image> hotelImages = imageService.getImagesByOwner(Image.OwnerType.HOTEL, id);
        for (Image image : hotelImages) {
            imageService.deleteImage(image.getId());
        }

        // Delete hotel (cascade will handle rooms, amenities, etc.)
        hotelRepository.delete(hotel);
    }

    // ═══════════════════════════════════════════════════════════
    // PRIVATE HELPER METHODS
    // ═══════════════════════════════════════════════════════════

    @Value("${upload.path:src/main/resources/static/uploads}")
    private String UPLOAD_DIR;
    private String buildImageFullUrl(Image image, Hotel hotel) {
        String filename = image.getImageUrl();  // hotel11_1
        Long hotelId = image.getOwnerId();
        String hotelFolder = "hotel" + hotelId;

        if (image.getOwnerType() == Image.OwnerType.HOTEL) {
            String[] possibleExtensions = {".jpg", ".jpeg", ".png", ".webp", ""};

            for (String ext : possibleExtensions) {
                Path filePath = Paths.get(UPLOAD_DIR, "hotel", hotelFolder, filename + ext);
                if (Files.exists(filePath)) {
                    return "/uploads/hotel/" + hotelFolder + "/" + filename + ext;
                }
            }

            // Default fallback
            return "/uploads/hotel/" + hotelFolder + "/" + filename + ".jpg";

        } else if (image.getOwnerType() == Image.OwnerType.ROOM_TYPE) {
            // Similar logic for room type images
            RoomType roomType = roomTypeRepository.findById(image.getOwnerId())
                    .orElse(null);

            if (roomType != null) {
                String roomTypeFolderName = toCamelCase(roomType.getName());
                String[] possibleExtensions = {".jpg", ".jpeg", ".png", ".webp", ""};

                for (String ext : possibleExtensions) {
                    Path filePath = Paths.get(UPLOAD_DIR, "hotel", hotelFolder,
                            roomTypeFolderName, filename + ext);
                    if (Files.exists(filePath)) {
                        return "/uploads/hotel/" + hotelFolder + "/" +
                                roomTypeFolderName + "/" + filename + ext;
                    }
                }

                // Default fallback
                return "/uploads/hotel/" + hotelFolder + "/" + roomTypeFolderName +
                        "/" + filename + ".jpg";
            }
        }

        return null;
    }

    private String toCamelCase(String input) {
        // Same implementation as ImageServiceImpl
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
                camelCase.append(word.substring(0, 1).toUpperCase()).append(word.substring(1));
            }
        }
        return camelCase.toString();
    }

    private FormOptionsDTO.AmenityDTO mapAmenityToDTO(Amenity amenity) {
        return FormOptionsDTO.AmenityDTO.builder()
                .id(amenity.getId())
                .name(amenity.getName())
                .code(amenity.getCode())
                .icon(amenity.getIcon())
                .category(amenity.getCategory() != null ? amenity.getCategory().name() : null)
                .build();
    }

    private void validateCreateRequest(CreateHotelRequestDTO request) {
        if (request.getBasicInfo() == null) {
            throw new RuntimeException("Thông tin cơ bản không được để trống");
        }
        if (request.getBasicInfo().getName() == null || request.getBasicInfo().getName().trim().isEmpty()) {
            throw new RuntimeException("Tên khách sạn không được để trống");
        }
        if (request.getBasicInfo().getManagerId() == null) {
            throw new RuntimeException("Phải chọn manager");
        }
        if (request.getRooms() == null || request.getRooms().isEmpty()) {
            throw new RuntimeException("Phải có ít nhất 1 phòng");
        }
        if (request.getHotelImages() == null || request.getHotelImages().isEmpty()) {
            throw new RuntimeException("Phải có ít nhất 1 ảnh khách sạn");
        }

        boolean hasPrimaryHotelImage = request.getHotelImages().stream()
                .anyMatch(img -> img.getIsPrimary() != null && img.getIsPrimary());
        if (!hasPrimaryHotelImage) {
            throw new RuntimeException("Phải chọn 1 ảnh đại diện cho khách sạn");
        }
    }

    private Hotel buildHotelEntity(CreateHotelRequestDTO.BasicInfoDTO basicInfo) {
        User manager = userRepository.findById(basicInfo.getManagerId())
                .orElseThrow(() -> new RuntimeException("Không thấy quản lý: " + basicInfo.getManagerId()));

        Hotel hotel = new Hotel();
        hotel.setName(basicInfo.getName());
        hotel.setDescription(basicInfo.getDescription());
        hotel.setAddress(basicInfo.getAddress());
        hotel.setCity(basicInfo.getCity());
        hotel.setType(Hotel.HotelType.valueOf(basicInfo.getType()));
        hotel.setStarRating(basicInfo.getStarRating());
        hotel.setFloor(basicInfo.getFloor());
        hotel.setCheckInTime(LocalTime.parse(basicInfo.getCheckInTime()));
        hotel.setCheckOutTime(LocalTime.parse(basicInfo.getCheckOutTime()));
        hotel.setCheckInInstructions(basicInfo.getCheckInInstructions());
        hotel.setPolicyText(basicInfo.getPolicyText());
        hotel.setManager(manager);
        hotel.setStatus(Hotel.HotelStatus.PENDING_REVIEW);
        return hotel;
    }

    private void saveHotelAmenitiesAndServices(Hotel hotel, CreateHotelRequestDTO.AmenitiesDTO amenitiesDTO) {
        // ══════════════════════════════════════════════════════════
        // 1. FREE AMENITIES → hotel_amenities table
        // ══════════════════════════════════════════════════════════
        if (amenitiesDTO.getFreeAmenityIds() != null) {
            for (Long amenityId : amenitiesDTO.getFreeAmenityIds()) {
                Amenity amenity = amenityRepository.findById(amenityId)
                        .orElseThrow(() -> new RuntimeException("Amenity not found: " + amenityId));

                HotelAmenity hotelAmenity = new HotelAmenity();
                hotelAmenity.setHotel(hotel);
                hotelAmenity.setAmenity(amenity);
                hotelAmenityRepository.save(hotelAmenity);
            }
        }

        // ══════════════════════════════════════════════════════════
        // 2. PAID AMENITIES (EXTRA SERVICES) → hotel_extra_services table
        // ══════════════════════════════════════════════════════════
        if (amenitiesDTO.getPaidAmenities() != null) {
            for (CreateHotelRequestDTO.PaidAmenityDTO paidDTO : amenitiesDTO.getPaidAmenities()) {
                Amenity amenity = amenityRepository.findById(paidDTO.getAmenityId())
                        .orElseThrow(() -> new RuntimeException("Amenity not found: " + paidDTO.getAmenityId()));

                PriceUnit unit = priceUnitRepository.findById(paidDTO.getUnitId())
                        .orElseThrow(() -> new RuntimeException("Price unit not found: " + paidDTO.getUnitId()));

                HotelExtraService extraService = new HotelExtraService();
                extraService.setHotel(hotel);
                extraService.setAmenity(amenity);
                extraService.setBasePrice(new BigDecimal(paidDTO.getBasePrice()));
                extraService.setPriceUnit(unit);
                hotelExtraServiceRepository.save(extraService);
            }
        }
    }

    private String getHotelTypeLabel(Hotel.HotelType type) {
        switch (type) {
            case HOTEL:
                return "Khách sạn";
            case RESORT:
                return "Khu nghỉ dưỡng";
            case HOMESTAY:
                return "Nhà nghỉ";
            default:
                return type.name();
        }
    }

    private String getHotelStatusLabel(Hotel.HotelStatus status) {
        switch (status) {
            case ACTIVE:
                return "Hoạt động";
            case CLOSED:
                return "Dừng hoạt động";
            case MAINTENANCE:
                return "Bảo trì";
            case PENDING_REVIEW:
                return "Đang duyệt";
            default:
                return status.name();
        }
    }


}