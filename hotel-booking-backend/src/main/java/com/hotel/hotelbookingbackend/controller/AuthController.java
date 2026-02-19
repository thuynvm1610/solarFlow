package com.hotel.hotelbookingbackend.controller;

import com.hotel.hotelbookingbackend.dto.LoginRequestDTO;
import com.hotel.hotelbookingbackend.dto.LoginResponseDTO;
import com.hotel.hotelbookingbackend.entity.User;
import com.hotel.hotelbookingbackend.service.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginRequestDTO request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );

        User user = (User) authentication.getPrincipal();
        String token = jwtService.generateToken(user);

        LoginResponseDTO response = LoginResponseDTO.builder()
                .id(user.getId())
                .email(user.getEmail())
                .fullName(user.getFullName())
                .role(user.getRole().name())
                .phone(user.getPhone())
                .imageUrl(user.getImageUrl())
                .token(token)
                .build();

        return ResponseEntity.ok(response);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout() {
        return ResponseEntity.ok().body("Đăng xuất thành công");
    }

    @GetMapping("/me")
    public ResponseEntity<LoginResponseDTO> getCurrentUser(Authentication authentication) {
        User user = (User) authentication.getPrincipal();

        LoginResponseDTO response = LoginResponseDTO.builder()
                .id(user.getId())
                .email(user.getEmail())
                .fullName(user.getFullName())
                .role(user.getRole().name())
                .phone(user.getPhone())
                .imageUrl(user.getImageUrl())
                .build();

        return ResponseEntity.ok(response);
    }
}