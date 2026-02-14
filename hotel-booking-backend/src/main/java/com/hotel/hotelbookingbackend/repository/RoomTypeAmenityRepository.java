package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.RoomTypeAmenity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoomTypeAmenityRepository extends JpaRepository<RoomTypeAmenity, Long> {

    List<RoomTypeAmenity> findByRoomTypeId(Long roomTypeId);

    List<RoomTypeAmenity> findByAmenityId(Long amenityId);

    @Query("SELECT rta FROM RoomTypeAmenity rta WHERE rta.roomType.id = :roomTypeId")
    List<RoomTypeAmenity> findAmenitiesByRoomTypeId(@Param("roomTypeId") Long roomTypeId);

    @Query("SELECT CASE WHEN COUNT(rta) > 0 THEN true ELSE false END " +
            "FROM RoomTypeAmenity rta WHERE rta.roomType.id = :roomTypeId AND rta.amenity.id = :amenityId")
    boolean existsByRoomTypeIdAndAmenityId(
            @Param("roomTypeId") Long roomTypeId,
            @Param("amenityId") Long amenityId
    );
}