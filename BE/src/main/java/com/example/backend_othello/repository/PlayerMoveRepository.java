package com.example.backend_othello.repository;

import com.example.backend_othello.entity.PlayerMove;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlayerMoveRepository extends JpaRepository<PlayerMove, String> {
}
