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
public class HotelResponseDTO {
    private Long id;
    private String name;
    private Integer floorNumber;
    private Hotel.HotelType type;
    private String description;
    private String address;
    private String city;
    private Integer starRating;
    private BigDecimal reviewRating;
    private LocalTime checkInTime;
    private LocalTime checkOutTime;
    private String phone;
    private String email;
    private String policyText;
    private String checkInInstructions;
    private Hotel.HotelStatus status;
    private Long managerId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Calculated fields
    private Long totalRooms;
    private Long totalBookings;
    private Long reviewCount;

    // Image
    private String primaryImageUrl;

    // Room types available
    private List<RoomTypeSimpleDTO> availableRoomTypes;
}