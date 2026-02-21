package com.hotel.hotelbookingbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "amenities")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Amenity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String code;

    @Column(nullable = false)
    private String name;

    @Column(length = 100)
    private String icon;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;

    // ============================================
    // ENUM
    // ============================================

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AmenityCategory category;

    public enum AmenityCategory {
        ROOM_FEATURE, FREE_SERVICE, EXTRA_SERVICE
    }

    // ============================================
    // RELATIONSHIP
    // ============================================

    @OneToMany(mappedBy = "amenity", cascade = CascadeType.ALL)
    private List<AmenityPromotion> amenityPromotions;

    @OneToMany(mappedBy = "amenity", cascade = CascadeType.ALL)
    private List<HotelAmenity> hotelAmenities;

    @OneToMany(mappedBy = "amenity", cascade = CascadeType.ALL)
    private List<RoomTypeAmenity> roomTypeAmenities;

    @OneToMany(mappedBy = "amenity", cascade = CascadeType.ALL)
    private List<HotelExtraService> hotelExtraServices;

    @OneToMany(mappedBy = "amenity", cascade = CascadeType.ALL)
    private List<BookingRoomService> bookingRoomServices;
}