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

    @Query("SELECT DISTINCT rt.name FROM RoomType rt ORDER BY rt.name")
    List<String> findDistinctRoomTypeNames();
}