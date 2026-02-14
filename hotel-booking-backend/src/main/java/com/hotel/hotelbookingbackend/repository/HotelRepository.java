package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HotelRepository extends JpaRepository<Hotel, Long> {

    List<Hotel> findByCity(String city);

    List<Hotel> findByStatus(String status);

    @Query("SELECT h FROM Hotel h WHERE h.starRating >= :rating")
    List<Hotel> findByMinimumRating(@Param("rating") Integer rating);

    @Query("SELECT h FROM Hotel h WHERE h.name LIKE %:keyword% OR h.city LIKE %:keyword%")
    List<Hotel> searchHotels(@Param("keyword") String keyword);
}