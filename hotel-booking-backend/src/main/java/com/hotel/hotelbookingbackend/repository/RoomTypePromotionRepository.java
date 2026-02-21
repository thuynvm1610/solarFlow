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

}