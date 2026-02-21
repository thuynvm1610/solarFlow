package com.hotel.hotelbookingbackend.dto;

import com.hotel.hotelbookingbackend.entity.Hotel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FilterOptionsDTO {
    private List<String> cities;
    private List<Hotel.HotelType> hotelTypes;
    private List<Hotel.HotelStatus> statuses;
    private List<RoomTypeSimpleDTO> roomTypes;
    private Integer minStarRating;
    private Integer maxStarRating;
    private Integer minFloors;
    private Integer maxFloors;
}