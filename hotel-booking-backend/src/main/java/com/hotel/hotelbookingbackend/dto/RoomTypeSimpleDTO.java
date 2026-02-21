package com.hotel.hotelbookingbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RoomTypeSimpleDTO {
    private Long id;
    private String name;
    private Long count;
}