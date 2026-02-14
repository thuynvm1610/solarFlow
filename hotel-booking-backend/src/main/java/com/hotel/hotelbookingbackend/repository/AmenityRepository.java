package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.Amenity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AmenityRepository extends JpaRepository<Amenity, Long> {

    Optional<Amenity> findByCode(String code);

    List<Amenity> findByCategory(Amenity.AmenityCategory category);

    List<Amenity> findByIsActive(Boolean isActive);

    @Query("SELECT a FROM Amenity a WHERE a.isActive = true")
    List<Amenity> findAllActive();

    @Query("SELECT a FROM Amenity a WHERE a.category = :category AND a.isActive = true")
    List<Amenity> findActiveByCategoryOrderByName(@Param("category") Amenity.AmenityCategory category);
}