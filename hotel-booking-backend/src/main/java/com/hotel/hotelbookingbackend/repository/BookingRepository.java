package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.dto.MonthlyRevenueDTO;
import com.hotel.hotelbookingbackend.dto.RecentBookingDTO;
import com.hotel.hotelbookingbackend.dto.TopHotelByBookingsDTO;
import com.hotel.hotelbookingbackend.dto.YearlyRevenueDTO;
import com.hotel.hotelbookingbackend.entity.Booking;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    @Query("""
            SELECT COUNT(b)
            FROM Booking b
            WHERE b.status = :status
            """)
    Long countByStatus(@Param("status") Booking.BookingStatus status);

    @Query("""
            SELECT SUM(b.totalPrice)
            FROM Booking b
            WHERE b.createdAt BETWEEN :start AND :end
              AND b.status IN :statuses
            """)
    BigDecimal sumRevenueByDateRange(
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end,
            @Param("statuses") List<Booking.BookingStatus> statuses
    );

    @Query("""
            SELECT new com.hotel.hotelbookingbackend.dto.MonthlyRevenueDTO(MONTH(b.paidAt), SUM(b.totalPrice))
            FROM Booking b WHERE YEAR(b.paidAt) = :year
            GROUP BY MONTH(b.paidAt) ORDER BY MONTH(b.paidAt)
            """)
    List<MonthlyRevenueDTO> getMonthlyRevenue(@Param("year") int year);

    @Query("SELECT new com.hotel.hotelbookingbackend.dto.RecentBookingDTO(b.id, b.bookingCode, u.fullName, " +
            "(SELECT r.roomNumber FROM BookingRoom br JOIN br.room r WHERE br.booking.id = b.id ORDER BY br.id ASC LIMIT 1), " +
            "b.checkInDate, b.checkOutDate, b.totalPrice, CAST(b.status AS string)) " +
            "FROM Booking b JOIN b.user u ORDER BY b.createdAt DESC")
    List<RecentBookingDTO> getRecentBookings(Pageable pageable);

    @Query("""
            SELECT new com.hotel.hotelbookingbackend.dto.TopHotelByBookingsDTO(h.id, h.name, COUNT(b))
            FROM Hotel h JOIN h.bookings b
            WHERE b.status NOT IN ('CANCELLED','PENDING')
            GROUP BY h.id, h.name
            ORDER BY COUNT(b) DESC
            """)
    List<TopHotelByBookingsDTO> getTopHotelsByBookings(Pageable pageable);

    @Query("""
            SELECT new com.hotel.hotelbookingbackend.dto.YearlyRevenueDTO(YEAR(b.paidAt), SUM(b.totalPrice))
            FROM Booking b
            GROUP BY YEAR(b.paidAt) ORDER BY YEAR(b.paidAt) DESC
            """)
    List<YearlyRevenueDTO> getYearlyRevenue(Pageable pageable);
}