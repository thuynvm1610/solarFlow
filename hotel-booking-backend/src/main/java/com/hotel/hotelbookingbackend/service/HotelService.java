package com.hotel.hotelbookingbackend.service;

import com.hotel.hotelbookingbackend.dto.FilterOptionsDTO;
import com.hotel.hotelbookingbackend.dto.HotelFilterDTO;
import com.hotel.hotelbookingbackend.dto.HotelResponseDTO;
import org.springframework.data.domain.Page;

public interface HotelService {
    Page<HotelResponseDTO> filterHotels(HotelFilterDTO filter);
    FilterOptionsDTO getFilterOptions();
    HotelResponseDTO getHotelById(Long id);
}