package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.dto.TopHotelByRatingDTO;
import com.hotel.hotelbookingbackend.entity.Review;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    @Query("""
            SELECT new com.hotel.hotelbookingbackend.dto.TopHotelByRatingDTO(h.id, h.name, AVG(r.rating), COUNT(r))
            FROM Hotel h JOIN h.reviews r
            GROUP BY h.id, h.name
            HAVING COUNT(r) >= 10
            ORDER BY AVG(r.rating) DESC, COUNT(r) DESC
            """)
    List<TopHotelByRatingDTO> getTopHotelsByRating(Pageable pageable);
}