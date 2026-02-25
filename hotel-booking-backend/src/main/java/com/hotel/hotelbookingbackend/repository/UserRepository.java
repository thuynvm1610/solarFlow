package com.hotel.hotelbookingbackend.repository;

import com.hotel.hotelbookingbackend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

    List<User> findByRoleIn(List<User.Role> roles);

    @Query("SELECT u FROM User u WHERE u.role = :role AND u.id NOT IN :excludeIds")
    List<User> findByRoleAndIdNotIn(@Param("role") User.Role role, @Param("excludeIds") List<Long> excludeIds);
}