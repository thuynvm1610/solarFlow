package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.dto.TopHotelByRatingDTO;
import com.hotel.hotelbookingbackend.entity.Review;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByHotelId(Long hotelId);

    List<Review> findByUserId(Long userId);

    @Query("SELECT AVG(r.rating) FROM Review r")
    Double getAverageRating();

    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.hotel.id = :hotelId")
    Double getAverageRatingByHotelId(@Param("hotelId") Long hotelId);

    @Query("SELECT r FROM Review r WHERE r.hotel.id = :hotelId ORDER BY r.createdAt DESC")
    List<Review> findByHotelIdOrderByCreatedAtDesc(@Param("hotelId") Long hotelId);

    @Query("SELECT r FROM Review r WHERE r.rating >= :minRating ORDER BY r.createdAt DESC")
    List<Review> findByMinimumRating(@Param("minRating") Integer minRating);

    // ✅ Thêm query mới
    @Query("SELECT new com.hotel.hotelbookingbackend.dto.TopHotelByRatingDTO(h.id, h.name, AVG(r.rating), COUNT(r)) " +
            "FROM Review r JOIN r.hotel h " +
            "GROUP BY h.id, h.name " +
            "HAVING COUNT(r) >= 3 " +
            "ORDER BY AVG(r.rating) DESC, COUNT(r) DESC")
    List<TopHotelByRatingDTO> getTopHotelsByRating(Pageable pageable);
}