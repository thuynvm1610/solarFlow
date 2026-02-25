package com.hotel.hotelbookingbackend.service;

import com.hotel.hotelbookingbackend.dto.*;
import com.hotel.hotelbookingbackend.entity.Hotel;
import org.springframework.data.domain.Page;

public interface HotelService {

    Page<HotelResponseDTO> filterHotels(HotelFilterDTO filter);
    FilterOptionsDTO getFilterOptions();
    HotelResponseDTO getHotelById(Long id);

    FormOptionsDTO getFormOptions();
    Hotel createHotel(CreateHotelRequestDTO request) throws Exception;
    HotelDetailDTO getHotelDetail(Long id);
    Hotel updateHotel(Long id, UpdateHotelRequestDTO request) throws Exception;
    void deleteHotel(Long id) throws Exception;
}