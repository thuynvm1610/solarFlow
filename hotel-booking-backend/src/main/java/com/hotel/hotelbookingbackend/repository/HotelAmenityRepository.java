package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.HotelAmenity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HotelAmenityRepository extends JpaRepository<HotelAmenity, Long> {

    List<HotelAmenity> findByHotelId(Long hotelId);

    List<HotelAmenity> findByAmenityId(Long amenityId);

    @Query("SELECT ha FROM HotelAmenity ha WHERE ha.hotel.id = :hotelId")
    List<HotelAmenity> findAmenitiesByHotelId(@Param("hotelId") Long hotelId);

    @Query("SELECT CASE WHEN COUNT(ha) > 0 THEN true ELSE false END " +
            "FROM HotelAmenity ha WHERE ha.hotel.id = :hotelId AND ha.amenity.id = :amenityId")
    boolean existsByHotelIdAndAmenityId(
            @Param("hotelId") Long hotelId,
            @Param("amenityId") Long amenityId
    );
}