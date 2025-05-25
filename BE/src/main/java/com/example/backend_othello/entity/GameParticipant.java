package com.example.backend_othello.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "GameParticipant")
@Data
public class GameParticipant {
    @Id
    @Column(length = 10)
    private String id;

    @Column(length = 10, nullable = true)
    private String result;

    @Column(length = 10, nullable = false)
    private String color;

//    @Column(length = 10, nullable = false)
//    private String gameId;

//    @ManyToOne
//    @JoinColumn(name = "gameId", nullable = false)
//    private Game game;

//    @Column(length = 10, nullable = false)
//    private String userId;

    @ManyToOne
    @JoinColumn(name = "userId", nullable = false)
    private User user;

}