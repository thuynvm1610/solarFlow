package com.hotel.hotelbookingbackend.service.impl;

import com.hotel.hotelbookingbackend.dto.*;
import com.hotel.hotelbookingbackend.entity.Booking;
import com.hotel.hotelbookingbackend.repository.*;
import com.hotel.hotelbookingbackend.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
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

    @Autowired
    private HotelRepository hotelRepository;

    @Override
    public DashboardStatsDTO getDashboardStats() {
        try {
            DashboardStatsDTO stats = new DashboardStatsDTO();

            // Total bookings
            stats.setTotalBookings(bookingRepository.count());

            // Active bookings
            Long activeBookings = bookingRepository.countByStatus(Booking.BookingStatus.CHECKED_IN);
            stats.setActiveBookings(activeBookings != null ? activeBookings : 0L);

            // Monthly revenue
            LocalDateTime startOfMonth = LocalDateTime.now()
                    .withDayOfMonth(1)
                    .withHour(0)
                    .withMinute(0)
                    .withSecond(0)
                    .withNano(0);

            BigDecimal revenue = bookingRepository.sumRevenueByDateRange(
                    startOfMonth,
                    LocalDateTime.now(),
                    List.of(
                            Booking.BookingStatus.CONFIRMED,
                            Booking.BookingStatus.CHECKED_IN,
                            Booking.BookingStatus.CHECKED_OUT
                    )
            );
            stats.setMonthlyRevenue(revenue != null ? revenue : BigDecimal.ZERO);

            // Rooms
            stats.setTotalRooms(roomRepository.count());

            Long availableRooms = roomRepository.countByStatus("AVAILABLE");
            stats.setAvailableRooms(availableRooms != null ? availableRooms : 0L);

            // Users
            stats.setTotalUsers(userRepository.count());

            // Rating
            Double avgRating = reviewRepository.getAverageRating();
            stats.setAverageRating(avgRating != null ? avgRating : 0.0);

            // Occupancy rate
            Long occupiedRooms = roomRepository.countByStatus("OCCUPIED");
            if (stats.getTotalRooms() > 0 && occupiedRooms != null) {
                stats.setOccupancyRate((double) occupiedRooms / stats.getTotalRooms() * 100);
            } else {
                stats.setOccupancyRate(0.0);
            }

            stats.setTotalHotels(hotelRepository.count());

            return stats;

        } catch (Exception e) {
            e.printStackTrace();
            DashboardStatsDTO emptyStats = new DashboardStatsDTO();
            emptyStats.setTotalBookings(0L);
            emptyStats.setActiveBookings(0L);
            emptyStats.setMonthlyRevenue(BigDecimal.ZERO);
            emptyStats.setTotalRooms(0L);
            emptyStats.setAvailableRooms(0L);
            emptyStats.setTotalUsers(0L);
            emptyStats.setAverageRating(0.0);
            emptyStats.setOccupancyRate(0.0);
            emptyStats.setTotalHotels(0L);
            return emptyStats;
        }
    }

    @Override
    public List<MonthlyRevenueDTO> getMonthlyRevenue(int year) {
        try {
            List<MonthlyRevenueDTO> revenue = bookingRepository.getMonthlyRevenue(year);
            return revenue != null ? revenue : new ArrayList<>();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public List<RecentBookingDTO> getRecentBookings(int limit) {
        try {
            List<RecentBookingDTO> bookings = bookingRepository.getRecentBookings(PageRequest.of(0, limit));
            return bookings != null ? bookings : new ArrayList<>();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // ✅ Thêm implementations mới
    @Override
    public List<HotelStatsByCityDTO> getHotelStatsByCity() {
        try {
            return hotelRepository.getHotelCountByCity();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public List<HotelStatsByStarDTO> getHotelStatsByStar() {
        try {
            return hotelRepository.getHotelCountByStar();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public List<TopHotelByBookingsDTO> getTopHotelsByBookings(int limit) {
        try {
            return bookingRepository.getTopHotelsByBookings(PageRequest.of(0, limit));
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public List<TopHotelByRatingDTO> getTopHotelsByRating(int limit) {
        try {
            return reviewRepository.getTopHotelsByRating(PageRequest.of(0, limit));
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public List<YearlyRevenueDTO> getYearlyRevenue(int limit) {
        try {
            return bookingRepository.getYearlyRevenue(PageRequest.of(0, limit));
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}