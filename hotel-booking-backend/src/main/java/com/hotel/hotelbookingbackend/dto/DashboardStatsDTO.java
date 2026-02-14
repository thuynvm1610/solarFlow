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
    private BigDecimal monthlyRevenue;
    private Long totalRooms;
    private Long availableRooms;
    private Long totalUsers;
    private Double averageRating;
    private Double occupancyRate;
}