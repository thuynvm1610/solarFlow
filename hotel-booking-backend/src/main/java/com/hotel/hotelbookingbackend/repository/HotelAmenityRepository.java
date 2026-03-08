package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.HotelAmenity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HotelAmenityRepository extends JpaRepository<HotelAmenity, Long> {

    List<HotelAmenity> findByHotelId(Long hotelId);

    @Modifying
    @Query("DELETE FROM HotelAmenity ha WHERE ha.hotel.id = :hotelId")
    void deleteByHotelId(@Param("hotelId") Long hotelId);
}