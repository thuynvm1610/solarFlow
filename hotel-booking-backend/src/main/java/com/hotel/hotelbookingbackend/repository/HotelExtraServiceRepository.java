package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.HotelExtraService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HotelExtraServiceRepository extends JpaRepository<HotelExtraService, Long> {

    List<HotelExtraService> findByHotelId(Long hotelId);

    List<HotelExtraService> findByAmenityId(Long amenityId);

    @Query("SELECT hes FROM HotelExtraService hes WHERE hes.hotel.id = :hotelId")
    List<HotelExtraService> findServicesByHotelId(@Param("hotelId") Long hotelId);
}