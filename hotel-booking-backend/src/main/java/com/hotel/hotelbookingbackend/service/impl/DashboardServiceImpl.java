package com.hotel.hotelbookingbackend.service.impl;

import com.hotel.hotelbookingbackend.dto.DashboardStatsDTO;
import com.hotel.hotelbookingbackend.dto.MonthlyRevenueDTO;
import com.hotel.hotelbookingbackend.dto.RecentBookingDTO;
import com.hotel.hotelbookingbackend.entity.Booking;
import com.hotel.hotelbookingbackend.repository.*;
import com.hotel.hotelbookingbackend.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class DashboardServiceImpl implements DashboardService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Override
    public DashboardStatsDTO getDashboardStats() {
        DashboardStatsDTO stats = new DashboardStatsDTO();

        // Total bookings
        stats.setTotalBookings(bookingRepository.count());

        // Active bookings (checked in)
        stats.setActiveBookings(bookingRepository.countByStatus(Booking.BookingStatus.valueOf("CHECKED_IN")));

        // Total revenue this month
        LocalDateTime startOfMonth = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0);
        BigDecimal revenue = bookingRepository.sumRevenueByDateRange(startOfMonth, LocalDateTime.now());
        stats.setMonthlyRevenue(revenue != null ? revenue : BigDecimal.ZERO);

        // Total rooms
        stats.setTotalRooms(roomRepository.count());

        // Available rooms
        Long availableRooms = roomRepository.countByStatus("AVAILABLE");
        stats.setAvailableRooms(availableRooms);

        // Total users
        stats.setTotalUsers(userRepository.count());

        // Average rating
        Double avgRating = reviewRepository.getAverageRating();
        stats.setAverageRating(avgRating != null ? avgRating : 0.0);

        // Occupancy rate
        Long occupiedRooms = roomRepository.countByStatus("OCCUPIED");
        if (stats.getTotalRooms() > 0) {
            stats.setOccupancyRate((double) occupiedRooms / stats.getTotalRooms() * 100);
        } else {
            stats.setOccupancyRate(0.0);
        }

        return stats;
    }

    @Override
    public List<MonthlyRevenueDTO> getMonthlyRevenue(int year) {
        return bookingRepository.getMonthlyRevenue(year);
    }

    @Override
    public List<RecentBookingDTO> getRecentBookings(int limit) {
        return bookingRepository.getRecentBookings(PageRequest.of(0, limit));
    }
}