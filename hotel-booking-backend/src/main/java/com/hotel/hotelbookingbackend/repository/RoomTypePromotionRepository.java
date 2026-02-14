package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.RoomTypePromotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface RoomTypePromotionRepository extends JpaRepository<RoomTypePromotion, Long> {

    List<RoomTypePromotion> findByRoomTypeId(Long roomTypeId);

    List<RoomTypePromotion> findByPromotionId(Long promotionId);

    @Query("SELECT rtp FROM RoomTypePromotion rtp " +
            "WHERE rtp.roomType.id = :roomTypeId " +
            "AND rtp.promotion.isActive = true " +
            "AND rtp.promotion.startDate <= :date " +
            "AND rtp.promotion.endDate >= :date")
    List<RoomTypePromotion> findActivePromotionsByRoomTypeId(
            @Param("roomTypeId") Long roomTypeId,
            @Param("date") LocalDate date
    );

    @Query("SELECT CASE WHEN COUNT(rtp) > 0 THEN true ELSE false END " +
            "FROM RoomTypePromotion rtp " +
            "WHERE rtp.roomType.id = :roomTypeId AND rtp.promotion.id = :promotionId")
    boolean existsByRoomTypeIdAndPromotionId(
            @Param("roomTypeId") Long roomTypeId,
            @Param("promotionId") Long promotionId
    );

    @Query("SELECT rtp FROM RoomTypePromotion rtp " +
            "JOIN FETCH rtp.promotion p " +
            "WHERE rtp.roomType.id = :roomTypeId " +
            "AND p.isActive = true " +
            "ORDER BY p.discountValue DESC")
    List<RoomTypePromotion> findActivePromotionsByRoomTypeIdOrderByDiscountDesc(
            @Param("roomTypeId") Long roomTypeId
    );
}