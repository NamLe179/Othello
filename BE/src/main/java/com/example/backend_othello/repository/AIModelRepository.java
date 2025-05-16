package com.example.backend_othello.repository;

import com.example.backend_othello.entity.AIModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AIModelRepository extends JpaRepository<AIModel, String> {
}
