package com.example.backend_othello.entity;

import lombok.Data;

@Data
public class PlayerMoveVo {
    private String gameId;
    private Integer positionX;
    private Integer positionY;
    private String color;
}
