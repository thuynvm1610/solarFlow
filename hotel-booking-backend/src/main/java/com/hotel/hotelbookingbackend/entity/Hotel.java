package com.hotel.hotelbookingbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Entity
@Table(name = "hotels")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Hotel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String name;

    @Column(nullable = false)
    private Integer floor;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private HotelType type;

    @Column(name = "star_rating")
    private Integer starRating;

    @Column(name = "review_rating", precision = 3, scale = 1)
    private BigDecimal reviewRating;

    @Column(name = "check_in_time")
    private LocalTime checkInTime;

    @Column(name = "check_out_time")
    private LocalTime checkOutTime;

    @Column(name = "check_in_instructions", columnDefinition = "TEXT")
    private String checkInInstructions;

    @Column(name = "policy_text", columnDefinition = "TEXT")
    private String policyText;

    @Column(nullable = false, length = 500)
    private String address;

    @Column(length = 30)
    private String city;

    @Column(name = "manager_id")
    private Long managerId;

    @Column(length = 20)
    private String status;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "hotel", cascade = CascadeType.ALL)
    private List<Room> rooms;

    @OneToMany(mappedBy = "hotel", cascade = CascadeType.ALL)
    private List<HotelAmenity> hotelAmenities;

    @OneToMany(mappedBy = "hotel", cascade = CascadeType.ALL)
    private List<HotelExtraService> hotelExtraServices;

    @OneToMany(mappedBy = "hotel", cascade = CascadeType.ALL)
    private List<Image> images;

    @OneToMany(mappedBy = "hotel", cascade = CascadeType.ALL)
    private List<Review> reviews;

    public enum HotelType {
        LUXURY, BOUTIQUE, RESORT, BUSINESS, BUDGET
    }
}