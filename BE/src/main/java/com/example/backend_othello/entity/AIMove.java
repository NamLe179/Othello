package com.example.backend_othello.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "AIMove")
@Data
public class AIMove {
    @Id
    @Column(length = 10)
    private String id;

    @Column(name = "positionX", nullable = true)
    private Integer positionX;

    @Column(name = "positionY", nullable = true)
    private Integer positionY;

//    @Column(length = 10, nullable = false)
//    private String color;

//    @Column(length = 10, nullable = false)
//    private String gameId;

    @ManyToOne
    @JoinColumn(name = "AIParticipantId", nullable = false)
    private AIParticipant aiParticipant;
}