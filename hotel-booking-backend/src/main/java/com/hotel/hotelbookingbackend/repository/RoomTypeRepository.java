package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.RoomType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface RoomTypeRepository extends JpaRepository<RoomType, Long> {

    List<RoomType> findByHotelId(Long hotelId);

    @Query("SELECT rt FROM RoomType rt WHERE rt.hotel.id = :hotelId AND rt.basePrice BETWEEN :minPrice AND :maxPrice")
    List<RoomType> findByHotelIdAndPriceRange(
            @Param("hotelId") Long hotelId,
            @Param("minPrice") BigDecimal minPrice,
            @Param("maxPrice") BigDecimal maxPrice
    );

    @Query("SELECT rt FROM RoomType rt WHERE rt.maxAdults >= :adults AND rt.maxChildren >= :children")
    List<RoomType> findByCapacity(
            @Param("adults") Integer adults,
            @Param("children") Integer children
    );
}