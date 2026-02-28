package com.hotel.hotelbookingbackend.controller;

import com.hotel.hotelbookingbackend.dto.*;
import com.hotel.hotelbookingbackend.entity.Hotel;
import com.hotel.hotelbookingbackend.repository.HotelRepository;
import com.hotel.hotelbookingbackend.service.HotelService;
import com.hotel.hotelbookingbackend.service.ImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/hotels")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class HotelController {

    private final HotelService hotelService;
    private final ImageService imageService;
    private final HotelRepository hotelRepository;

    // ═══════════════════════════════════════════════════════════
    // FILTER, GET
    // ═══════════════════════════════════════════════════════════

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

    // ═══════════════════════════════════════════════════════════
    // CREATE, EDIT
    // ═══════════════════════════════════════════════════════════

    /**
     * Get form options for Create/Edit hotel
     */
    @GetMapping("/form-options")
    public ResponseEntity<FormOptionsDTO> getFormOptions() {
        FormOptionsDTO options = hotelService.getFormOptions();
        return ResponseEntity.ok(options);
    }

    /**
     * Upload temporary image
     */
    @PostMapping("/images/temp")
    public ResponseEntity<TempImageUploadResponseDTO> uploadTempImage(@RequestParam("file") MultipartFile file) {
        System.out.println(">>> uploadTempImage called");
        try {
            String tempPath = imageService.uploadTempImage(file);
            return ResponseEntity.ok(TempImageUploadResponseDTO.builder()
                    .tempPath(tempPath)
                    .message("Upload thành công")
                    .build());
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(TempImageUploadResponseDTO.builder()
                            .message(e.getMessage())
                            .build());
        }
    }

    /**
     * Create new hotel
     */
    @PostMapping
    public ResponseEntity<?> createHotel(@RequestBody CreateHotelRequestDTO request) {
        try {
            Hotel hotel = hotelService.createHotel(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(hotel);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    /**
     * Get hotel detail for edit
     */
    @GetMapping("/{id}/detail")
    public ResponseEntity<HotelDetailDTO> getHotelDetail(@PathVariable Long id) {
        HotelDetailDTO detail = hotelService.getHotelDetail(id);
        return ResponseEntity.ok(detail);
    }

    /**
     * Update hotel
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateHotel(@PathVariable Long id, @RequestBody UpdateHotelRequestDTO request) {
        try {
            Hotel hotel = hotelService.updateHotel(id, request);
            return ResponseEntity.ok(hotel);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // ═══════════════════════════════════════════════════════════
    // DELETE
    // ═══════════════════════════════════════════════════════════

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteHotel(@PathVariable Long id) {
        try {
            hotelService.deleteHotel(id);
            return ResponseEntity.ok("Xóa khách sạn thành công");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}