package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoomRepository extends JpaRepository<Room, Long> {

    List<Room> findByHotelId(Long hotelId);

    List<Room> findByStatus(String status);

    @Query("SELECT COUNT(r) FROM Room r WHERE r.status = :status")
    Long countByStatus(@Param("status") String status);

    @Query("SELECT r FROM Room r WHERE r.hotel.id = :hotelId AND r.status = 'AVAILABLE'")
    List<Room> findAvailableRoomsByHotelId(@Param("hotelId") Long hotelId);

    @Query("SELECT r FROM Room r WHERE r.roomType.id = :roomTypeId AND r.status = 'AVAILABLE'")
    List<Room> findAvailableRoomsByRoomTypeId(@Param("roomTypeId") Long roomTypeId);
}