package com.hotel.hotelbookingbackend.service.impl;

import com.hotel.hotelbookingbackend.dto.*;
import com.hotel.hotelbookingbackend.entity.Hotel;
import com.hotel.hotelbookingbackend.entity.RoomType;
import com.hotel.hotelbookingbackend.repository.HotelRepository;
import com.hotel.hotelbookingbackend.repository.RoomTypeRepository;
import com.hotel.hotelbookingbackend.service.HotelService;
import com.hotel.hotelbookingbackend.specification.HotelSpecification;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class HotelServiceImpl implements HotelService {

    private final HotelRepository hotelRepository;
    private final RoomTypeRepository roomTypeRepository;

    @Override
    public Page<HotelResponseDTO> filterHotels(HotelFilterDTO filter) {
        // Build specification
        Specification<Hotel> spec = HotelSpecification.filterHotels(filter);

        // Build pageable
        Sort sort = Sort.by(
                filter.getSortDirection().equalsIgnoreCase("DESC")
                        ? Sort.Direction.DESC
                        : Sort.Direction.ASC,
                filter.getSortBy()
        );
        Pageable pageable = PageRequest.of(filter.getPage(), filter.getSize(), sort);

        // Execute query
        Page<Hotel> hotelPage = hotelRepository.findAll(spec, pageable);

        // Map to DTO
        return hotelPage.map(this::mapToResponseDTO);
    }

    @Override
    public FilterOptionsDTO getFilterOptions() {
        // Get distinct cities
        List<String> cities = hotelRepository.findDistinctCities();

        // Get hotel types
        List<Hotel.HotelType> hotelTypes = Arrays.asList(Hotel.HotelType.values());

        // Get statuses
        List<Hotel.HotelStatus> statuses = Arrays.asList(Hotel.HotelStatus.values());

        // Get room types
        List<RoomType> roomTypeEntities = roomTypeRepository.findAllDistinctRoomTypes();
        List<RoomTypeSimpleDTO> roomTypes = roomTypeEntities.stream()
                .map(rt -> RoomTypeSimpleDTO.builder()
                        .id(rt.getId())
                        .name(rt.getName())
                        .build())
                .collect(Collectors.toList());

        // Get min/max values
        Integer minStarRating = hotelRepository.findMinStarRating();
        Integer maxStarRating = hotelRepository.findMaxStarRating();
        Integer minFloors = hotelRepository.findMinFloorNumber();
        Integer maxFloors = hotelRepository.findMaxFloorNumber();

        return FilterOptionsDTO.builder()
                .cities(cities)
                .hotelTypes(hotelTypes)
                .statuses(statuses)
                .roomTypes(roomTypes)
                .minStarRating(minStarRating != null ? minStarRating : 1)
                .maxStarRating(maxStarRating != null ? maxStarRating : 5)
                .minFloors(minFloors != null ? minFloors : 1)
                .maxFloors(maxFloors != null ? maxFloors : 50)
                .build();
    }

    @Override
    public HotelResponseDTO getHotelById(Long id) {
        Hotel hotel = hotelRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel not found"));
        return mapToResponseDTO(hotel);
    }

    private HotelResponseDTO mapToResponseDTO(Hotel hotel) {
        // Count rooms
        Long totalRooms = hotelRepository.countRoomsByHotelId(hotel.getId());

        // Count bookings
        Long totalBookings = hotelRepository.countBookingsByHotelId(hotel.getId());

        // Count reviews
        Long reviewCount = hotelRepository.countReviewsByHotelId(hotel.getId());

        // ✅ GET PRIMARY IMAGE
        String primaryImageUrl = hotelRepository.findPrimaryImageByHotelId(hotel.getId());

        // If no primary image, construct default path
        if (primaryImageUrl == null || primaryImageUrl.isEmpty()) {
            // Default: /uploads/hotel/hotel{id}/hotel{id}_1.jpg
            primaryImageUrl = String.format("hotel%d_1.jpg", hotel.getId());
        }

        // Get available room types - DEDUPLICATED
        List<RoomTypeSimpleDTO> availableRoomTypes = hotel.getRooms() != null
                ? hotel.getRooms().stream()
                .collect(Collectors.groupingBy(
                        room -> room.getRoomType(),
                        Collectors.counting()
                ))
                .entrySet().stream()
                .map(entry -> RoomTypeSimpleDTO.builder()
                        .id(entry.getKey().getId())
                        .name(entry.getKey().getName())
                        .count(entry.getValue())
                        .build())
                .sorted(Comparator.comparing(RoomTypeSimpleDTO::getName))
                .collect(Collectors.toList())
                : List.of();

        return HotelResponseDTO.builder()
                .id(hotel.getId())
                .name(hotel.getName())
                .floorNumber(hotel.getFloor())
                .type(hotel.getType())
                .description(hotel.getDescription())
                .address(hotel.getAddress())
                .city(hotel.getCity())
                .starRating(hotel.getStarRating())
                .reviewRating(hotel.getReviewRating())
                .checkInTime(hotel.getCheckInTime())
                .checkOutTime(hotel.getCheckOutTime())
                .phone(hotel.getManager().getPhone())
                .email(hotel.getManager().getEmail())
                .policyText(hotel.getPolicyText())
                .checkInInstructions(hotel.getCheckInInstructions())
                .status(hotel.getStatus())
                .managerId(hotel.getManager().getId())
                .createdAt(hotel.getCreatedAt())
                .updatedAt(hotel.getUpdatedAt())
                .totalRooms(totalRooms)
                .totalBookings(totalBookings)
                .reviewCount(reviewCount)
                .primaryImageUrl(primaryImageUrl)
                .availableRoomTypes(availableRoomTypes)
                .build();
    }
}