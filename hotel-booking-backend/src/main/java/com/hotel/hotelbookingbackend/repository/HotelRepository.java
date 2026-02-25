package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.dto.HotelStatsByCityDTO;
import com.hotel.hotelbookingbackend.dto.HotelStatsByStarDTO;
import com.hotel.hotelbookingbackend.dto.HotelStatsByTypeDTO;
import com.hotel.hotelbookingbackend.entity.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface HotelRepository extends JpaRepository<Hotel, Long>, JpaSpecificationExecutor<Hotel> {

    Long countByStatus(Hotel.HotelStatus status);

    @Query("""
            SELECT new com.hotel.hotelbookingbackend.dto.HotelStatsByCityDTO(h.city, COUNT(h))
            FROM Hotel h
            GROUP BY h.city
            ORDER BY COUNT(h) DESC
            """)
    List<HotelStatsByCityDTO> getHotelCountByCity();

    @Query("""
            SELECT new com.hotel.hotelbookingbackend.dto.HotelStatsByStarDTO(h.starRating, COUNT(h))
            FROM Hotel h
            GROUP BY h.starRating
            ORDER BY h.starRating
            """)
    List<HotelStatsByStarDTO> getHotelCountByStar();

    @Query("""
            SELECT new com.hotel.hotelbookingbackend.dto.HotelStatsByTypeDTO(h.type, COUNT(h))
            FROM Hotel h
            GROUP BY h.type
            """)
    List<HotelStatsByTypeDTO> getHotelStatsByType();

    // Get distinct cities
    @Query("SELECT DISTINCT h.city FROM Hotel h ORDER BY h.city")
    List<String> findDistinctCities();

    // Get min/max star rating
    @Query("SELECT MIN(h.starRating) FROM Hotel h")
    Integer findMinStarRating();

    @Query("SELECT MAX(h.starRating) FROM Hotel h")
    Integer findMaxStarRating();

    // Get min/max floor number
    @Query("SELECT MIN(h.floor) FROM Hotel h WHERE h.floor IS NOT NULL")
    Integer findMinFloorNumber();

    @Query("SELECT MAX(h.floor) FROM Hotel h WHERE h.floor IS NOT NULL")
    Integer findMaxFloorNumber();

    // Count total rooms for a hotel
    @Query("SELECT COUNT(r) FROM Room r WHERE r.hotel.id = :hotelId")
    Long countRoomsByHotelId(Long hotelId);

    // Count total bookings for a hotel
    @Query("SELECT COUNT(DISTINCT b) FROM Booking b JOIN b.bookingRooms br JOIN br.room r WHERE r.hotel.id = :hotelId")
    Long countBookingsByHotelId(Long hotelId);

    // Get review count for a hotel
    @Query("SELECT COUNT(r) FROM Review r WHERE r.hotel.id = :hotelId")
    Long countReviewsByHotelId(Long hotelId);

    @Query("SELECT i.imageUrl FROM Image i WHERE i.ownerType = 'HOTEL' AND i.ownerId = :hotelId AND i.isPrimary = true")
    String findPrimaryImageByHotelId(@Param("hotelId") Long hotelId);

    @Query("SELECT DISTINCT h.manager.id FROM Hotel h WHERE h.manager.id IS NOT NULL")
    List<Long> findAllManagerIds();
}