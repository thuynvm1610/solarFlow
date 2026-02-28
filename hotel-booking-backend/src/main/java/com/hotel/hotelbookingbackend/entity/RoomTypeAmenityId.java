package com.hotel.hotelbookingbackend.entity;

import java.io.Serializable;
import lombok.Data;

@Data
public class RoomTypeAmenityId implements Serializable {

    private Long roomType;
    private Long amenity;
}