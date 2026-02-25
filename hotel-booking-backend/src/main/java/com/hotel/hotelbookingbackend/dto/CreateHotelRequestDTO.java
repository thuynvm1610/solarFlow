package com.hotel.hotelbookingbackend.dto;

import lombok.Data;
import java.util.List;

@Data
public class CreateHotelRequestDTO {
    private BasicInfoDTO basicInfo;
    private AmenitiesDTO amenities;
    private List<RoomTypeCreateDTO> customRoomTypes;
    private List<RoomDTO> rooms;
    private List<RoomTypeImagesDTO> roomTypeImages;
    private List<ImageDTO> hotelImages;

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
    }

    @Data
    public static class AmenitiesDTO {
        private List<Long> freeAmenityIds;
        private List<PaidAmenityDTO> paidAmenities;
    }

    @Data
    public static class PaidAmenityDTO {
        private Long amenityId;
        private String basePrice;
        private Long unitId;
    }

    @Data
    public static class RoomTypeCreateDTO {
        private String tempId;
        private String name;
        private String description;
        private Integer maxAdults;
        private Integer maxChildren;
        private String basePrice;
        private Integer areaM2;
        private List<Long> featureIds;
    }

    @Data
    public static class RoomDTO {
        private String roomNumber;
        private String roomTypeTempId;
    }

    @Data
    public static class RoomTypeImagesDTO {
        private String roomTypeTempId;
        private List<ImageDTO> images;
    }

    @Data
    public static class ImageDTO {
        private String tempPath;
        private Boolean isPrimary;
    }
}