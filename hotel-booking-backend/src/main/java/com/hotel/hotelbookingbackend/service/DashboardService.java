package com.hotel.hotelbookingbackend.service;

import com.hotel.hotelbookingbackend.dto.*;

import java.util.List;

public interface DashboardService {

    DashboardStatsDTO getDashboardStats();

    List<MonthlyRevenueDTO> getMonthlyRevenue(int year);

    List<HotelStatsByCityDTO> getHotelStatsByCity();

    List<HotelStatsByStarDTO> getHotelStatsByStar();

    List<TopHotelByBookingsDTO> getTopHotelsByBookings(int limit);

    List<TopHotelByRatingDTO> getTopHotelsByRating(int limit);

    List<YearlyRevenueDTO> getYearlyRevenue(int limit);
}