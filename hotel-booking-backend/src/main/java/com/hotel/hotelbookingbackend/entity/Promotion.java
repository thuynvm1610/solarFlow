package com.hotel.hotelbookingbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "promotions")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Promotion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(name = "discount_value", precision = 10, scale = 2, nullable = false)
    private BigDecimal discountValue;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;

    // ============================================
    // ENUM
    // ============================================

    @Enumerated(EnumType.STRING)
    @Column(name = "discount_type", nullable = false)
    private DiscountType discountType;

    public enum DiscountType {
        PERCENT, FIXED
    }

    // ============================================
    // RELATIONSHIP
    // ============================================

    @OneToMany(mappedBy = "promotion", cascade = CascadeType.ALL)
    private List<RoomTypePromotion> roomTypePromotions;

    @OneToMany(mappedBy = "promotion", cascade = CascadeType.ALL)
    private List<AmenityPromotion> amenityPromotions;
}