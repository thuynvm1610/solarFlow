package com.hotel.hotelbookingbackend.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHasher {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        System.out.println("123456: " + encoder.encode("123456"));
        System.out.println("manager123: " + encoder.encode("manager123"));
        System.out.println("customer123: " + encoder.encode("customer123"));
    }
}