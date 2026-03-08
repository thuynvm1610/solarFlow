package com.hotel.hotelbookingbackend.dto;

import lombok.Data;
import java.math.BigDecimal;
import java.util.List;

/**
 * DTO for PUT /hotels/{id}
 * Covers all safe-to-update fields as per requirements.
 */
@Data
public class UpdateHotelRequestDTO {

    private BasicInfoDTO basicInfo;
    private AmenitiesDTO amenities;

    // Rooms
    private List<ExistingRoomDTO> existingRooms;      // rooms to update (type, number, floor, status)
    private List<NewRoomDTO> newRooms;                 // rooms to add
    private List<Long> deletedRoomIds;                 // rooms to delete (non-booked only)

    // Room types
    private List<RoomTypeUpdateDTO> roomTypes;         // safe fields: name, desc, area, maxAdults, maxChildren

    // Images
    private List<TempImageDTO> newHotelImages;
    private List<ExistingImageDTO> existingHotelImages; // to update isPrimary
    private List<Long> deletedImageIds;
    private List<RoomTypeImagesDTO> roomTypeImages;

    // ─── Inner DTOs ───────────────────────────────────────────────

    @Data
    public static class BasicInfoDTO {
        private String name;
        private String description;
        private String address;
        private String city;
        private String type;          // NOT updatable per spec — kept for completeness but ignored in service
        private Integer starRating;
        private Integer floor;        // NOT updatable per spec — kept for completeness but ignored in service
        private String checkInTime;   // "HH:mm"
        private String checkOutTime;  // "HH:mm"
        private String checkInInstructions;
        private String policyText;
        private String status;        // ACTIVE | CLOSED | MAINTENANCE | PENDING_REVIEW
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
    public static class ExistingRoomDTO {
        private Long roomId;
        private Long roomTypeId;
        private String roomNumber;   // updatable
        private Integer floor;       // updatable
        private String status;       // AVAILABLE | OCCUPIED | MAINTENANCE
    }

    @Data
    public static class NewRoomDTO {
        private String roomNumber;
        private Integer floorNumber;
        private Long roomTypeId;
    }

    @Data
    public static class RoomTypeUpdateDTO {
        private Long roomTypeId;
        private String name;
        private String description;
        private Integer areaM2;
        private Integer maxAdults;
        private Integer maxChildren;
        // basePrice intentionally NOT included (not in safe-update list)
        private List<Long> featureIds;  // room_type_amenities
    }

    @Data
    public static class TempImageDTO {
        private String tempPath;
        private Boolean isPrimary;
    }

    @Data
    public static class ExistingImageDTO {
        private Long imageId;
        private Boolean isPrimary;
        private Boolean deleted;    // true → delete this image
    }

    @Data
    public static class RoomTypeImagesDTO {
        private Long roomTypeId;
        private List<TempImageDTO> newImages;
        private List<ExistingImageDTO> existingImages;
    }
}