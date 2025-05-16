package com.example.backend_othello.controller;

import com.example.backend_othello.entity.TKUser;
import com.example.backend_othello.service.RankingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//API xử lý thống kê xem BXH
@RestController
@RequestMapping("/api/rankings")
public class RankingController {
    @Autowired
    private RankingService rankingService;

    //Lấy BXH người chơi theo chế độ và thời gian
    @GetMapping
    public ResponseEntity<List<TKUser>> getRankings(
            @RequestParam String gameType,
            @RequestParam String timeRange) {
        List<TKUser> rankings = rankingService.getRankings(gameType, timeRange);
        return ResponseEntity.ok(rankings); 
    }
}
