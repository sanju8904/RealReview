package com.realreview.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.realreview.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
