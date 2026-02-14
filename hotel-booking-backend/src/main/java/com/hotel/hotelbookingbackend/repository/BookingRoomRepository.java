package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.BookingRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookingRoomRepository extends JpaRepository<BookingRoom, Long> {

    List<BookingRoom> findByBookingId(Long bookingId);

    List<BookingRoom> findByRoomId(Long roomId);

    @Query("SELECT br FROM BookingRoom br WHERE br.booking.id = :bookingId")
    List<BookingRoom> findRoomsByBookingId(@Param("bookingId") Long bookingId);
}