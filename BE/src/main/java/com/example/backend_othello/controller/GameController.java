package com.example.backend_othello.controller;

import com.example.backend_othello.entity.AIModel;
import com.example.backend_othello.entity.Game;
import com.example.backend_othello.entity.Move;
import com.example.backend_othello.entity.PlayerMove;
import com.example.backend_othello.service.GameService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/game")
public class GameController {
    @Autowired
    private GameService gameService;

    //API lấy ds tất cả AI
    @GetMapping("/ai-models")
    public ResponseEntity<List<AIModel>> getAIModels() {
        return ResponseEntity.ok(gameService.getAIModels());
    }

    @PostMapping("/start")
    public ResponseEntity<Game> startGame(@RequestParam String aiModelId, @RequestParam String userId) {
        Game game = gameService.startGame(aiModelId, userId);
        return ResponseEntity.ok(game);
    }

    //API để bắt đầu ván chơi
    @PostMapping("/move")
    public ResponseEntity<Move> processMove(@Valid @RequestBody PlayerMove userMove) {

        Move aiMove = gameService.processMove(userMove);
        return ResponseEntity.ok(aiMove);
    }

    //API kết thúc ván chơi
    @PostMapping("/end")
    public void endGame(
            @RequestParam String gameId,
            @RequestParam String userId,
            @RequestParam String winner, //Nhận người thắng, điểm số từ FE
            @RequestParam int scoreBlack,
            @RequestParam int scoreWhite) {

        gameService.endGame(gameId, userId, winner, scoreBlack, scoreWhite);

    }

    //API chơi lại
    @PostMapping("/replay")
    public ResponseEntity<Game> replayGame(@RequestParam String gameId) {
        Game newGame = gameService.replayGame(gameId);
        return ResponseEntity.ok(newGame);
    }
}