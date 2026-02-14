package com.hotel.hotelbookingbackend.service;

import com.hotel.hotelbookingbackend.dto.DashboardStatsDTO;
import com.hotel.hotelbookingbackend.dto.MonthlyRevenueDTO;
import com.hotel.hotelbookingbackend.dto.RecentBookingDTO;

import java.util.List;

public interface DashboardService {

    DashboardStatsDTO getDashboardStats();

    List<MonthlyRevenueDTO> getMonthlyRevenue(int year);

    List<RecentBookingDTO> getRecentBookings(int limit);
}