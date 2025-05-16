package com.example.backend_othello.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "AIModel")
@Data
public class AIModel {
    @Id
    @Column(length = 10)
    private String id;

    @Column(length = 20, nullable = false)
    private String name;

    @Column(length = 255, nullable = true)
    private String description;

    @Column(length = 10, nullable = false)
    private String difficulty;

    @Column(name = "createdAt",nullable = false)
    private Date createdAt;

    @Column(name = "updatedAt",nullable = false)
    private Date updatedAt;

    @Column(name = "serviceUrl",length = 100, nullable = false)
    private String serviceUrl;
}
