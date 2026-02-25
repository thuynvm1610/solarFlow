package com.hotel.hotelbookingbackend.dto;

import lombok.Data;
import java.util.List;

@Data
public class UpdateHotelRequestDTO {
    private BasicInfoDTO basicInfo;
    private AmenitiesDTO amenities;

    // Images
    private List<Long> deletedHotelImageIds;  // IDs ảnh cần xóa
    private List<ImageDTO> newHotelImages;     // Ảnh mới upload
    private Long primaryHotelImageId;          // ID ảnh đại diện (existing hoặc new)

    // Rooms
    private List<Long> deletedRoomIds;         // IDs phòng cần xóa
    private List<RoomDTO> newRooms;            // Phòng mới
    private List<RoomUpdateDTO> updatedRooms;  // Phòng cần update loại

    // Room type images
    private List<RoomTypeImagesDTO> roomTypeImages;

    @Data
    public static class BasicInfoDTO {
        private String name;
        private String description;
        private String address;
        private String city;
        private String type;
        private Integer starRating;
        private Integer floor;
        private String checkInTime;
        private String checkOutTime;
        private String checkInInstructions;
        private String policyText;
        private Long managerId;
        private String status;  // ACTIVE, INACTIVE, MAINTENANCE
    }

    @Data
    public static class AmenitiesDTO {
        private List<Long> freeAmenityIds;
        private List<ExtraServiceDTO> extraServices;  // Bao gồm cả existing và new
    }

    @Data
    public static class ExtraServiceDTO {
        private Long extraServiceId;  // null nếu là new
        private Long amenityId;
        private String basePrice;
        private Long unitId;
        private Boolean isDeleted;    // true nếu muốn xóa
    }

    @Data
    public static class RoomDTO {
        private String roomNumber;
        private Long roomTypeId;
    }

    @Data
    public static class RoomUpdateDTO {
        private Long roomId;
        private Long roomTypeId;
    }

    @Data
    public static class RoomTypeImagesDTO {
        private Long roomTypeId;
        private List<Long> deletedImageIds;
        private List<ImageDTO> newImages;
        private Long primaryImageId;
    }

    @Data
    public static class ImageDTO {
        private String tempPath;
        private Boolean isPrimary;
    }
}