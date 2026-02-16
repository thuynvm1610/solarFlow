package com.hotel.hotelbookingbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TopHotelByRatingDTO {
    private Long hotelId;
    private String hotelName;
    private Double averageRating;
    private Long reviewCount;
}
