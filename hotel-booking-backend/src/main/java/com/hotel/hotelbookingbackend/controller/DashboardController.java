package com.hotel.hotelbookingbackend.controller;

import com.hotel.hotelbookingbackend.dto.*;
import com.hotel.hotelbookingbackend.service.DashboardService;
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

    @GetMapping("/hotels/by-city")
    public ResponseEntity<List<HotelStatsByCityDTO>> getHotelStatsByCity() {
        return ResponseEntity.ok(dashboardService.getHotelStatsByCity());
    }

    @GetMapping("/hotels/by-star")
    public ResponseEntity<List<HotelStatsByStarDTO>> getHotelStatsByStar() {
        return ResponseEntity.ok(dashboardService.getHotelStatsByStar());
    }

    @GetMapping("/hotels/top-bookings")
    public ResponseEntity<List<TopHotelByBookingsDTO>> getTopHotelsByBookings(
            @RequestParam(defaultValue = "3") int limit) {
        return ResponseEntity.ok(dashboardService.getTopHotelsByBookings(limit));
    }

    @GetMapping("/hotels/top-ratings")
    public ResponseEntity<List<TopHotelByRatingDTO>> getTopHotelsByRating(
            @RequestParam(defaultValue = "3") int limit) {
        return ResponseEntity.ok(dashboardService.getTopHotelsByRating(limit));
    }

    @GetMapping("/revenue/yearly")
    public ResponseEntity<List<YearlyRevenueDTO>> getYearlyRevenue(
            @RequestParam(defaultValue = "3") int limit) {
        return ResponseEntity.ok(dashboardService.getYearlyRevenue(limit));
    }
}