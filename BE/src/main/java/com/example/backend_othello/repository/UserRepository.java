package com.example.backend_othello.repository;

import com.example.backend_othello.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {
    User findByUserName(String userName);
}
