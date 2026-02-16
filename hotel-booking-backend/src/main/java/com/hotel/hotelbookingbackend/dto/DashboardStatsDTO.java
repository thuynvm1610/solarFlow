package com.hotel.hotelbookingbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DashboardStatsDTO {
    private Long totalBookings;
    private Long activeBookings;
    private Long totalRooms;
    private Long availableRooms;  // Phòng trống (có thể thuê)
    private Long maintenanceRooms;  // Phòng đang bảo trì (không thể thuê)
    private Long occupiedRooms; // Phòng đang được thuê
    private Long totalHotels;
    private Long activeHotels;
    private Long totalUsers;
    private BigDecimal monthlyRevenue;
}