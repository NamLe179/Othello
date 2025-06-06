package com.example.backend_othello.entity;


import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "PlayerMove")
@Data
public class PlayerMove {
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
    @JoinColumn(name = "gameParticipantId", nullable = false)
    private GameParticipant gameParticipant;
}
