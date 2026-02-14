package com.hotel.hotelbookingbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "hotel_extra_services")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class HotelExtraService {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "hotel_id", nullable = false)
    private Hotel hotel;

    @ManyToOne
    @JoinColumn(name = "amenity_id", nullable = false)
    private Amenity amenity;

    @Column(name = "base_price", precision = 12, scale = 2)
    private BigDecimal basePrice;

    @ManyToOne
    @JoinColumn(name = "unit_id", nullable = false)
    private PriceUnit priceUnit;
}