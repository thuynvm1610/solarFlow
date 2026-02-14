package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.Booking;
import com.hotel.hotelbookingbackend.dto.MonthlyRevenueDTO;
import com.hotel.hotelbookingbackend.dto.RecentBookingDTO;
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

    Optional<Booking> findByBookingCode(String bookingCode);

    List<Booking> findByUserId(Long userId);

    List<Booking> findByHotelId(Long hotelId);

    List<Booking> findByStatus(Booking.BookingStatus status);

    @Query("SELECT COUNT(b) FROM Booking b WHERE b.status = :status")
    Long countByStatus(@Param("status") Booking.BookingStatus status);

    @Query("SELECT SUM(b.totalPrice) FROM Booking b WHERE b.createdAt BETWEEN :start AND :end AND b.status != 'CANCELLED'")
    BigDecimal sumRevenueByDateRange(
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end
    );

    @Query("SELECT new com.hotel.hotelbookingbackend.dto.MonthlyRevenueDTO(MONTH(b.checkInDate), SUM(b.totalPrice)) " +
            "FROM Booking b WHERE YEAR(b.checkInDate) = :year AND b.status != 'CANCELLED' " +
            "GROUP BY MONTH(b.checkInDate) ORDER BY MONTH(b.checkInDate)")
    List<MonthlyRevenueDTO> getMonthlyRevenue(@Param("year") int year);

    // ✅ QUERY MỚI: Lấy room number từ BookingRoom
    @Query("SELECT new com.hotel.hotelbookingbackend.dto.RecentBookingDTO(b.id, b.bookingCode, u.fullName, " +
            "(SELECT r.roomNumber FROM BookingRoom br JOIN br.room r WHERE br.booking.id = b.id ORDER BY br.id ASC LIMIT 1), " +
            "b.checkInDate, b.checkOutDate, b.totalPrice, CAST(b.status AS string)) " +
            "FROM Booking b JOIN b.user u ORDER BY b.createdAt DESC")
    List<RecentBookingDTO> getRecentBookings(Pageable pageable);

    // ✅ XÓA query này vì không còn b.room
    // @Query("SELECT b FROM Booking b WHERE b.room.id = :roomId ...")
    // List<Booking> findConflictingBookings(...);

    @Query("SELECT b FROM Booking b WHERE b.user.id = :userId ORDER BY b.createdAt DESC")
    List<Booking> findByUserIdOrderByCreatedAtDesc(@Param("userId") Long userId);

    // ✅ THÊM query mới để check conflict qua BookingRoom
    @Query("SELECT b FROM Booking b " +
            "JOIN b.bookingRooms br " +
            "WHERE br.room.id = :roomId " +
            "AND ((b.checkInDate BETWEEN :checkIn AND :checkOut) " +
            "OR (b.checkOutDate BETWEEN :checkIn AND :checkOut) " +
            "OR (b.checkInDate <= :checkIn AND b.checkOutDate >= :checkOut)) " +
            "AND b.status NOT IN ('CANCELLED', 'EXPIRED')")
    List<Booking> findConflictingBookings(
            @Param("roomId") Long roomId,
            @Param("checkIn") LocalDate checkIn,
            @Param("checkOut") LocalDate checkOut
    );
}