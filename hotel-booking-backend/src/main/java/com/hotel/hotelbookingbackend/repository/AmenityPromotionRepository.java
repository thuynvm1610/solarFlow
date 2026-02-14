package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.AmenityPromotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AmenityPromotionRepository extends JpaRepository<AmenityPromotion, Long> {

    List<AmenityPromotion> findByPromotionId(Long promotionId);

    List<AmenityPromotion> findByAmenityId(Long amenityId);
}