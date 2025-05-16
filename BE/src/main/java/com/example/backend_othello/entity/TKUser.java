package com.example.backend_othello.entity;

import com.example.backend_othello.entity.User;

import java.util.Date;

public class TKUser extends User {
    private Date startDate;
    private Date endDate;
    private String gameType;
    private Long wins;

    public TKUser() {
        super();
    }

    // Constructor cho query
    public TKUser(String id, String userName, String email, Date startDate, Date endDate, String gameType, Long wins) {
        //Kế thừa từ User
        setId(id);
        setUserName(userName);
        setEmail(email);

        this.startDate = startDate;
        this.endDate = endDate;
        this.gameType = gameType;
        this.wins = wins;
    }

    // Getters, setters
    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getGameType() {
        return gameType;
    }

    public void setGameType(String gameType) {
        this.gameType = gameType;
    }

    public Long getWins() {
        return wins;
    }

    public void setWins(Long wins) {
        this.wins = wins;
    }
}