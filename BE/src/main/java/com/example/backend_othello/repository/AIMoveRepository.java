package com.example.backend_othello.repository;

import com.example.backend_othello.entity.AIMove;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AIMoveRepository extends JpaRepository<AIMove, String> {
}
