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

    @Column(nullable = false, length = 50)
    private String code;

    @Column(nullable = false)
    private String name;

    @Column(length = 100)
    private String icon;

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private AmenityCategory category;

    @Column(name = "is_active")
    private Boolean isActive;

    @OneToMany(mappedBy = "amenity", cascade = CascadeType.ALL)
    private List<HotelAmenity> hotelAmenities;

    @OneToMany(mappedBy = "amenity", cascade = CascadeType.ALL)
    private List<RoomTypeAmenity> roomTypeAmenities;

    public enum AmenityCategory {
        GENERAL, BATHROOM, BEDROOM, ENTERTAINMENT, FOOD_DRINK, SERVICES, OUTDOOR
    }
}