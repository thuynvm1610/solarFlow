package com.hotel.hotelbookingbackend.specification;

import com.hotel.hotelbookingbackend.dto.HotelFilterDTO;
import com.hotel.hotelbookingbackend.entity.Hotel;
import com.hotel.hotelbookingbackend.entity.Room;
import com.hotel.hotelbookingbackend.entity.RoomType;
import jakarta.persistence.criteria.*;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public class HotelSpecification {

    public static Specification<Hotel> filterHotels(HotelFilterDTO filter) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            // Name filter (LIKE search)
            if (filter.getName() != null && !filter.getName().trim().isEmpty()) {
                predicates.add(criteriaBuilder.like(
                        criteriaBuilder.lower(root.get("name")),
                        "%" + filter.getName().toLowerCase() + "%"
                ));
            }

            // Floor number filters
            if (filter.getFloorNumber() != null) {
                predicates.add(criteriaBuilder.equal(root.get("floorNumber"), filter.getFloorNumber()));
            }
            if (filter.getMinFloors() != null) {
                predicates.add(criteriaBuilder.greaterThanOrEqualTo(root.get("floorNumber"), filter.getMinFloors()));
            }
            if (filter.getMaxFloors() != null) {
                predicates.add(criteriaBuilder.lessThanOrEqualTo(root.get("floorNumber"), filter.getMaxFloors()));
            }

            // Hotel type filter
            if (filter.getType() != null) {
                predicates.add(criteriaBuilder.equal(root.get("type"), filter.getType()));
            }

            // City filter
            if (filter.getCity() != null && !filter.getCity().trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("city"), filter.getCity()));
            }

            // Star rating filters
            if (filter.getStarRating() != null) {
                predicates.add(criteriaBuilder.equal(root.get("starRating"), filter.getStarRating()));
            }
            if (filter.getMinStarRating() != null) {
                predicates.add(criteriaBuilder.greaterThanOrEqualTo(root.get("starRating"), filter.getMinStarRating()));
            }
            if (filter.getMaxStarRating() != null) {
                predicates.add(criteriaBuilder.lessThanOrEqualTo(root.get("starRating"), filter.getMaxStarRating()));
            }

            // Review rating filters
            if (filter.getMinReviewRating() != null) {
                predicates.add(criteriaBuilder.greaterThanOrEqualTo(root.get("reviewRating"), filter.getMinReviewRating()));
            }
            if (filter.getMaxReviewRating() != null) {
                predicates.add(criteriaBuilder.lessThanOrEqualTo(root.get("reviewRating"), filter.getMaxReviewRating()));
            }

            // Status filter
            if (filter.getStatus() != null) {
                predicates.add(criteriaBuilder.equal(root.get("status"), filter.getStatus()));
            }

            if (filter.getRoomTypeNames() != null && !filter.getRoomTypeNames().isEmpty()) {
                Subquery<Long> roomSubquery = query.subquery(Long.class);
                Root<Room> roomRoot = roomSubquery.from(Room.class);
                Join<Room, RoomType> roomTypeJoin = roomRoot.join("roomType");

                roomSubquery.select(roomRoot.get("hotel").get("id"))
                        .distinct(true)
                        .where(roomTypeJoin.get("name").in(filter.getRoomTypeNames()));

                predicates.add(root.get("id").in(roomSubquery));
            }

            // Total rooms filter
            if (filter.getMinTotalRooms() != null || filter.getMaxTotalRooms() != null) {
                Subquery<Long> roomCountSubquery = query.subquery(Long.class);
                Root<Room> roomRoot = roomCountSubquery.from(Room.class);
                roomCountSubquery.select(criteriaBuilder.count(roomRoot))
                        .where(criteriaBuilder.equal(roomRoot.get("hotel").get("id"), root.get("id")));

                if (filter.getMinTotalRooms() != null) {
                    predicates.add(criteriaBuilder.greaterThanOrEqualTo(roomCountSubquery, filter.getMinTotalRooms()));
                }
                if (filter.getMaxTotalRooms() != null) {
                    predicates.add(criteriaBuilder.lessThanOrEqualTo(roomCountSubquery, filter.getMaxTotalRooms()));
                }
            }

            // Set distinct for main query if filtering by room types
            if (filter.getRoomTypeNames() != null && !filter.getRoomTypeNames().isEmpty()) {
                query.distinct(true);
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
    }
}