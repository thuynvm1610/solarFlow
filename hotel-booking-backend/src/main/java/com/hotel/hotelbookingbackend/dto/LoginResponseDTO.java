package com.hotel.hotelbookingbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginResponseDTO {
    private Long id;
    private String email;
    private String fullName;
    private String role;
    private String phone;
    private String imageUrl;
    private String token;
}