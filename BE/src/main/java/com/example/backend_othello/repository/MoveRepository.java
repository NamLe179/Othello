package com.example.backend_othello.repository;

import com.example.backend_othello.entity.Move;
import org.springframework.data.jpa.repository.JpaRepository;


public interface MoveRepository extends JpaRepository<Move, String> {
}