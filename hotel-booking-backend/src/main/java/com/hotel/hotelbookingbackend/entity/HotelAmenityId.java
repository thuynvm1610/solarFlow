package com.hotel.hotelbookingbackend.entity;

import java.io.Serializable;
import lombok.Data;

@Data
public class HotelAmenityId implements Serializable {
    private Long hotel;
    private Long amenity;
}