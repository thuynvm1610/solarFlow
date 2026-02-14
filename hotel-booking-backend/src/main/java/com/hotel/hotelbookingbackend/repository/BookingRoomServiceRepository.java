package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.BookingRoomService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookingRoomServiceRepository extends JpaRepository<BookingRoomService, Long> {

    List<BookingRoomService> findByBookingRoomId(Long bookingRoomId);

    List<BookingRoomService> findByAmenityId(Long amenityId);
}