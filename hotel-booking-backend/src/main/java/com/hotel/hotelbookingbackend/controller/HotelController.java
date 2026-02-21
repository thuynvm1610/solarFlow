package com.hotel.hotelbookingbackend.controller;

import com.hotel.hotelbookingbackend.dto.FilterOptionsDTO;
import com.hotel.hotelbookingbackend.dto.HotelFilterDTO;
import com.hotel.hotelbookingbackend.dto.HotelResponseDTO;
import com.hotel.hotelbookingbackend.repository.HotelRepository;
import com.hotel.hotelbookingbackend.service.HotelService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/hotels")
@RequiredArgsConstructor
public class HotelController {

    private final HotelService hotelService;
    private final HotelRepository hotelRepository;

    @PostMapping("/filter")
    public ResponseEntity<Page<HotelResponseDTO>> filterHotels(@RequestBody HotelFilterDTO filter) {
        Page<HotelResponseDTO> hotels = hotelService.filterHotels(filter);
        return ResponseEntity.ok(hotels);
    }

    @GetMapping("/filter-options")
    public ResponseEntity<FilterOptionsDTO> getFilterOptions() {
        FilterOptionsDTO options = hotelService.getFilterOptions();
        return ResponseEntity.ok(options);
    }

    @GetMapping("/{id}")
    public ResponseEntity<HotelResponseDTO> getHotelById(@PathVariable Long id) {
        HotelResponseDTO hotel = hotelService.getHotelById(id);
        return ResponseEntity.ok(hotel);
    }

    @GetMapping("/count")
    public ResponseEntity<Long> getTotalCount() {
        long count = hotelRepository.count();
        return ResponseEntity.ok(count);
    }
}