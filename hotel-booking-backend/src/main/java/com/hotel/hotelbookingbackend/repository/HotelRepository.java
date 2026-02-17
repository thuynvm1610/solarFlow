package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.dto.HotelStatsByCityDTO;
import com.hotel.hotelbookingbackend.dto.HotelStatsByStarDTO;
import com.hotel.hotelbookingbackend.entity.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface HotelRepository extends JpaRepository<Hotel, Long> {

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
}