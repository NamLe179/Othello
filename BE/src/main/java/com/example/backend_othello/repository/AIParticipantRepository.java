package com.example.backend_othello.repository;

import com.example.backend_othello.entity.AIParticipant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AIParticipantRepository extends JpaRepository<AIParticipant, String> {

    @Query("SELECT ai FROM AIParticipant ai JOIN Game g ON ai.id = g.aiParticipant.id WHERE g.id = :gameId")
    AIParticipant findByGameId(@Param("gameId") String gameId);
}
