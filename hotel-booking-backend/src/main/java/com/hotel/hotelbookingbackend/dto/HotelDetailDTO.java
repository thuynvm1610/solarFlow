package com.hotel.hotelbookingbackend.dto;

import com.hotel.hotelbookingbackend.entity.Hotel;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

/**
 * Full detail DTO returned by GET /hotels/{id}/detail
 * Used to pre-populate the Edit Hotel modal.
 */
@Data
@Builder
public class HotelDetailDTO {

    // ── Basic Info ───────────────────────────────────────────────
    private Long id;
    private String name;
    private String description;
    private String address;
    private String city;
    private Hotel.HotelType type;
    private Integer starRating;
    private Integer floorNumber;
    private LocalTime checkInTime;
    private LocalTime checkOutTime;
    private String checkInInstructions;
    private String policyText;
    private Hotel.HotelStatus status;
    private Long managerId;
    private BigDecimal reviewRating;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // ── Amenities ────────────────────────────────────────────────
    private List<Long> freeAmenityIds;
    private List<ExtraServiceDTO> extraServices;   // paid services with price/unit

    // ── Rooms & Room Types ────────────────────────────────────────
    private List<RoomDetailDTO> rooms;
    private List<RoomTypeDetailDTO> roomTypes;     // all room types for this hotel

    // ── Images ───────────────────────────────────────────────────
    private List<ImageDTO> hotelImages;
    private List<RoomTypeImageDTO> roomTypeImages;

    // ── Stats ─────────────────────────────────────────────────────
    private Long totalRooms;
    private Long totalBookings;
    private Long reviewCount;

    // ── Inner DTOs ────────────────────────────────────────────────

    @Data
    @Builder
    public static class ExtraServiceDTO {
        private Long extraServiceId;
        private Long amenityId;
        private String amenityName;
        private String amenityCode;
        private BigDecimal basePrice;
        private Long unitId;
        private String unitName;
    }

    @Data
    @Builder
    public static class RoomDetailDTO {
        private Long roomId;
        private String roomNumber;
        private Integer floorNumber;
        private Long roomTypeId;
        private String roomTypeName;
        private String status;
        private Boolean isBooked;
    }

    @Data
    @Builder
    public static class RoomTypeDetailDTO {
        private Long roomTypeId;
        private String name;
        private String description;
        private Integer maxAdults;
        private Integer maxChildren;
        private BigDecimal basePrice;
        private Integer areaM2;
        private List<Long> featureIds;
    }

    @Data
    @Builder
    public static class ImageDTO {
        private Long imageId;
        private String imageUrl;
        private String fullUrl;   // resolved full path for display
        private Boolean isPrimary;
    }

    @Data
    @Builder
    public static class RoomTypeImageDTO {
        private Long roomTypeId;
        private String roomTypeName;
        private List<ImageDTO> images;
    }
}