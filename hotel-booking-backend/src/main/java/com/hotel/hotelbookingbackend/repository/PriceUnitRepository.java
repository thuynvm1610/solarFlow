package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.PriceUnit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PriceUnitRepository extends JpaRepository<PriceUnit, Long> {

    Optional<PriceUnit> findByCode(String code);

    Optional<PriceUnit> findByName(String name);
}