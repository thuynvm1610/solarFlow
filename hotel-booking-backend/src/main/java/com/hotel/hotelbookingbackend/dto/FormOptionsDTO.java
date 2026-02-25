package com.hotel.hotelbookingbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FormOptionsDTO {
    private List<ManagerDTO> managers;
    private List<AmenityDTO> freeServices;
    private List<AmenityDTO> extraServices;
    private List<AmenityDTO> roomFeatures;
    private List<RoomTypeDTO> roomTypes;
    private List<PriceUnitDTO> priceUnits;
    private List<HotelTypeOption> hotelTypes;
    private List<HotelStatusOption> hotelStatuses;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ManagerDTO {
        private Long id;
        private String fullName;
        private String email;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class AmenityDTO {
        private Long id;
        private String name;
        private String code;
        private String icon;
        private String category;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class RoomTypeDTO {
        private Long id;
        private String name;
        private String description;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class PriceUnitDTO {
        private Long id;
        private String name;
        private String code;
        private String description;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class HotelTypeOption {
        private String value;
        private String label;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class HotelStatusOption {
        private String value;
        private String label;
    }
}