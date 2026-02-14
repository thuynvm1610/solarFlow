package com.hotel.hotelbookingbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "price_units")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PriceUnit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 50)
    private String code;

    @Column(nullable = false, length = 100)
    private String name;

    @Column
    private String description;

    @OneToMany(mappedBy = "priceUnit", cascade = CascadeType.ALL)
    private List<HotelExtraService> hotelExtraServices;

    @OneToMany(mappedBy = "priceUnit", cascade = CascadeType.ALL)
    private List<BookingRoomService> bookingRoomServices;
}