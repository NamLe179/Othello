package com.example.backend_othello.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "Game")
@Data
public class Game {
    @Id
    @Column(length = 10)
    private String id;

    @Column(name = "startDateTime",nullable = false)
    private Date startDateTime;

    @Column(name = "endDateTime",nullable = true)
    private Date endDateTime;

    @Column(name = "scoreBlack",nullable = false)
    private Integer scoreBlack;

    @Column(name = "scoreWhite", nullable = false)
    private Integer scoreWhite;

    @Column(name = "gameType", length = 10, nullable = false)
    private String gameType; //PvP, PvE_HARD, PvE_EASY

//    @Column(length = 10, nullable = true)
//    private String AIParticipantId;

    //Có thể null với chế độ PvP
    @ManyToOne
    @JoinColumn(name = "AIParticipantId", nullable = true)
    private AIParticipant aiParticipant;

}