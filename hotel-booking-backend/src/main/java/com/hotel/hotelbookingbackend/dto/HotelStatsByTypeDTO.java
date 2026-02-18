package com.hotel.hotelbookingbackend.dto;

import com.hotel.hotelbookingbackend.entity.Hotel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HotelStatsByTypeDTO {
    private Hotel.HotelType type;
    private Long hotelCount;
}
