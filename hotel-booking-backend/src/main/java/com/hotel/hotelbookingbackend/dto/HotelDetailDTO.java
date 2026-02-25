package com.hotel.hotelbookingbackend.dto;

import com.hotel.hotelbookingbackend.entity.Hotel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class HotelDetailDTO {
    // Basic info
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

    // Amenities
    private List<Long> freeAmenityIds;
    private List<ExtraServiceDTO> extraServices;

    // Rooms
    private List<RoomDetailDTO> rooms;

    // Images
    private List<ImageDTO> hotelImages;
    private List<RoomTypeImageDTO> roomTypeImages;

    // Statistics
    private Long totalRooms;
    private Long totalBookings;
    private Long reviewCount;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ExtraServiceDTO {
        private Long extraServiceId;  // ID trong hotel_extra_services
        private Long amenityId;
        private String amenityName;
        private String amenityCode;
        private BigDecimal basePrice;
        private Long unitId;
        private String unitName;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
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
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ImageDTO {
        private Long imageId;
        private String imageUrl;
        private Boolean isPrimary;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class RoomTypeImageDTO {
        private Long roomTypeId;
        private String roomTypeName;
        private List<ImageDTO> images;
    }
}