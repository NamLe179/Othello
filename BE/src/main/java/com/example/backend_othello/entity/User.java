package com.example.backend_othello.entity;


import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "User")
@Data 
public class User {
    @Id
    @Column(length = 10)
    private String id;

    @Column(name = "userName", length = 50, nullable = false)
    private String userName;

    @Column(name = "passWord", length = 50, nullable = false)
    private String passWord;

    @Column(length = 50, nullable = false)
    private String email;

    @Column(length = 10, nullable = false)
    private String role;

    @Column(name = "isActive", nullable = false)
    private Integer isActive;

}

