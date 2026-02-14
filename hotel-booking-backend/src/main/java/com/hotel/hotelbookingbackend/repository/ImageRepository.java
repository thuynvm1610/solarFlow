package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {

    List<Image> findByOwnerTypeAndOwnerId(Image.OwnerType ownerType, Long ownerId);

    Optional<Image> findByOwnerTypeAndOwnerIdAndIsPrimary(
            Image.OwnerType ownerType,
            Long ownerId,
            Boolean isPrimary
    );

    @Query("SELECT i FROM Image i WHERE i.ownerType = :ownerType AND i.ownerId = :ownerId ORDER BY i.isPrimary DESC")
    List<Image> findByOwnerTypeAndOwnerIdOrderByIsPrimaryDesc(
            @Param("ownerType") Image.OwnerType ownerType,
            @Param("ownerId") Long ownerId
    );

    @Query("SELECT i FROM Image i WHERE i.hotel.id = :hotelId")
    List<Image> findByHotelId(@Param("hotelId") Long hotelId);
}