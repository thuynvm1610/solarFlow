package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.Promotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PromotionRepository extends JpaRepository<Promotion, Long> {

    List<Promotion> findByIsActive(Boolean isActive);

    @Query("SELECT p FROM Promotion p WHERE p.isActive = true " +
            "AND p.startDate <= :currentDate AND p.endDate >= :currentDate")
    List<Promotion> findActivePromotions(@Param("currentDate") LocalDate currentDate);

    @Query("SELECT DISTINCT p FROM Promotion p " +
            "JOIN p.roomTypePromotions rtp " +
            "WHERE rtp.roomType.id = :roomTypeId " +
            "AND p.isActive = true " +
            "AND p.startDate <= :date " +
            "AND p.endDate >= :date")
    List<Promotion> findActivePromotionsByRoomTypeId(
            @Param("roomTypeId") Long roomTypeId,
            @Param("date") LocalDate date
    );

    @Query("SELECT p FROM Promotion p " +
            "WHERE p.isActive = true " +
            "AND :date BETWEEN p.startDate AND p.endDate " +
            "ORDER BY p.discountValue DESC")
    List<Promotion> findActivePromotionsByDate(@Param("date") LocalDate date);

    @Query("SELECT DISTINCT p FROM Promotion p " +
            "JOIN p.roomTypePromotions rtp " +
            "WHERE rtp.roomType.hotel.id = :hotelId " +
            "AND p.isActive = true")
    List<Promotion> findActivePromotionsByHotelId(@Param("hotelId") Long hotelId);
}