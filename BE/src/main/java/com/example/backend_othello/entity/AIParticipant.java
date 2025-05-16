package com.example.backend_othello.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "AIParticipant")
@Data 
public class AIParticipant {
    @Id
    @Column(length = 10)
    private String id;

    @Column(length = 10)
    private String result;

    @Column(length = 10, nullable = false)
    private String color;

//    @Column(length = 10, nullable = false)
//    private String AIModelId;

    @ManyToOne
    @JoinColumn(name = "AIModelId", nullable = false)
    private AIModel aiModel;
}
