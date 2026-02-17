package com.hotel.hotelbookingbackend.service.impl;

import com.hotel.hotelbookingbackend.dto.*;
import com.hotel.hotelbookingbackend.entity.Booking;
import com.hotel.hotelbookingbackend.entity.Hotel;
import com.hotel.hotelbookingbackend.entity.Room;
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

            // Active bookings (checked in)
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

            // Total rooms
            stats.setTotalRooms(roomRepository.count());

            // Available rooms - Phòng trống (có thể thuê)
            Long availableRooms = roomRepository.countByStatus(Room.RoomStatus.AVAILABLE);
            stats.setAvailableRooms(availableRooms != null ? availableRooms : 0L);

            // Occupied rooms - Phòng đang được thuê
            Long occupiedRooms = roomRepository.countByStatus(Room.RoomStatus.OCCUPIED);
            stats.setOccupiedRooms(occupiedRooms != null ? occupiedRooms : 0L);

            // Maintenance rooms - Phòng đang bảo trì (không thể thuê)
            Long maintenanceRooms = roomRepository.countByStatus(Room.RoomStatus.MAINTENANCE);
            stats.setMaintenanceRooms(maintenanceRooms != null ? maintenanceRooms : 0L);

            // Total users
            stats.setTotalUsers(userRepository.count());

            // Total hotels
            stats.setTotalHotels(hotelRepository.count());

            // Active hotels
            Long activeHotels = hotelRepository.countByStatus(Hotel.HotelStatus.ACTIVE);
            stats.setActiveHotels(activeHotels);

            return stats;

        } catch (Exception e) {
            e.printStackTrace();
            DashboardStatsDTO emptyStats = new DashboardStatsDTO();
            emptyStats.setTotalBookings(0L);
            emptyStats.setActiveBookings(0L);
            emptyStats.setMonthlyRevenue(BigDecimal.ZERO);
            emptyStats.setTotalRooms(0L);
            emptyStats.setAvailableRooms(0L);
            emptyStats.setOccupiedRooms(0L);
            emptyStats.setMaintenanceRooms(0L);
            emptyStats.setTotalUsers(0L);
            emptyStats.setTotalHotels(0L);
            emptyStats.setActiveHotels(0L);
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