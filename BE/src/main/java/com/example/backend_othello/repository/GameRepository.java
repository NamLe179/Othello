package com.example.backend_othello.repository;

import com.example.backend_othello.entity.Game;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GameRepository extends JpaRepository<Game, String> {
}
