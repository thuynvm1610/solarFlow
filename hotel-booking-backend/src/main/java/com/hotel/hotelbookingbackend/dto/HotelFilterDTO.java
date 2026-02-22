package com.hotel.hotelbookingbackend.dto;

import com.hotel.hotelbookingbackend.entity.Hotel;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class HotelFilterDTO {
    // Text search
    private String name;

    // Number filters
    private Integer floorNumber;
    private Integer minFloors;
    private Integer maxFloors;

    // Enum filters
    private Hotel.HotelType type;
    private Hotel.HotelStatus status;

    // Location
    private String city;

    // Star rating
    private Integer starRating;
    private Integer minStarRating;
    private Integer maxStarRating;

    // Review rating
    private BigDecimal minReviewRating;
    private BigDecimal maxReviewRating;

    // Room count
    private Long minTotalRooms;
    private Long maxTotalRooms;

    // Booking count
    private Long minTotalBookings;
    private Long maxTotalBookings;

    private List<String> roomTypeNames;

    // Pagination
    private Integer page = 0;
    private Integer size = 20;

    // Sorting
    private String sortBy = "id";
    private String sortDirection = "ASC";
}