package com.hotel.hotelbookingbackend.controller;

import com.hotel.hotelbookingbackend.dto.DashboardStatsDTO;
import com.hotel.hotelbookingbackend.dto.MonthlyRevenueDTO;
import com.hotel.hotelbookingbackend.dto.RecentBookingDTO;
import com.hotel.hotelbookingbackend.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/dashboard")
@CrossOrigin(origins = "*")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping("/stats")
    public ResponseEntity<DashboardStatsDTO> getDashboardStats() {
        return ResponseEntity.ok(dashboardService.getDashboardStats());
    }

    @GetMapping("/revenue/monthly")
    public ResponseEntity<List<MonthlyRevenueDTO>> getMonthlyRevenue(@RequestParam int year) {
        return ResponseEntity.ok(dashboardService.getMonthlyRevenue(year));
    }

    @GetMapping("/bookings/recent")
    public ResponseEntity<List<RecentBookingDTO>> getRecentBookings(
            @RequestParam(defaultValue = "10") int limit) {
        return ResponseEntity.ok(dashboardService.getRecentBookings(limit));
    }
}