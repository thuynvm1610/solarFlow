package com.hotel.hotelbookingbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TopHotelByBookingsDTO {
    private Long hotelId;
    private String hotelName;
    private Long bookingCount;
}
