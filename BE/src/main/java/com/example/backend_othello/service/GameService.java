package com.example.backend_othello.service;


import com.example.backend_othello.entity.*;
import com.example.backend_othello.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

//Quản lý hoạt động chơi Game

@Service
public class GameService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private AIModelRepository aiModelRepository;

    @Autowired
    private GameRepository gameRepository;

    @Autowired
    private GameParticipantRepository gameParticipantRepository;

    @Autowired
    private AIParticipantRepository aiParticipantRepository;

    @Autowired
    private MoveRepository moveRepository;

    @Autowired
    private RestTemplate restTemplate;

    //Lấy danh sách AI từ bảng AIModel
    public List<AIModel> getAIModels() {
        return aiModelRepository.findAll();
    }

    //Bắt đầu Game với AiModel và User
    public Game startGame(String aiModelId, String userId) {
        User user = userRepository.findById(userId).orElseThrow();
        //Xác định độ khó theo AIModelId
        AIModel aiModel = aiModelRepository.findById(aiModelId).orElseThrow();
        String difficulty = aiModel.getDifficulty();
        String gameType = "PvE_" + difficulty; //Cập nhật GameType theo độ khó

        // Tạo Game
        Game game = new Game();
        game.setId(UUID.randomUUID().toString().substring(0, 10));
        game.setStartDateTime(new Date());
        game.setGameType(gameType);
        game.setScoreBlack(2);
        game.setScoreWhite(2);


        // Tạo AIParticipant
        AIParticipant aiParticipant = new AIParticipant();
        aiParticipant.setId(UUID.randomUUID().toString().substring(0, 10));
        aiParticipant.setAiModel(aiModel);
        aiParticipant.setColor("WHITE"); //Cho AI mặc định đi sau = màu trắng
        aiParticipantRepository.save(aiParticipant);

        // Gán AIParticipantId vào Game
        game.setAiParticipant(aiParticipant);
        gameRepository.save(game);

        // Tạo GameParticipant
        GameParticipant userParticipant = new GameParticipant();
        userParticipant.setId(UUID.randomUUID().toString().substring(0, 10));
        userParticipant.setGame(game);
        userParticipant.setUser(user);
        userParticipant.setColor("BLACK"); //Mặc định người chơi đi trước
        gameParticipantRepository.save(userParticipant);

        // Reset game trên service AI
        Map<String, Object> resetRequest = new HashMap<>();
        restTemplate.postForObject(aiModel.getServiceUrl() + "/reset", resetRequest, Map.class);

        return game;
    }

    public Move processMove(PlayerMoveVo userMove) {
        //Lấy thông tin từ req

        Game game = gameRepository.findById(userMove.getGameId()).orElseThrow(); //Tìm AI theo gameId

        Move move = new Move();

        Integer positionX = userMove.getPositionX();
        Integer positionY = userMove.getPositionY();

        // Lưu nước đi của người chơi vào bảng Move
        if (positionX != null && positionY != null) {
            move.setId(UUID.randomUUID().toString().substring(0, 10));
            move.setPositionX(positionX);
            move.setPositionY(positionY);
            move.setColor(userMove.getColor());
            move.setGame(game);
            moveRepository.save(move);
        }

        // Chuẩn bị request với nước đi của người chơi gửi tới service của AI
        Map<String, Object> serviceRequest = new HashMap<>();
        if (positionX != null && positionY != null) {
            serviceRequest.put("positionX", positionX);
            serviceRequest.put("positionY", positionY);
        }

        // Gửi nước đi tới serviceUrl của AIModel

        AIParticipant aiParticipant = aiParticipantRepository.findByGameId(game.getId());
        AIModel aiModel = aiParticipant.getAiModel();
        Map<String, Object> serviceResponse = restTemplate.postForObject(aiModel.getServiceUrl() + "/play", serviceRequest, Map.class);

        // Xử lý response từ service
        Integer aiPositionX = (Integer) serviceResponse.get("aiPositionX");
        Integer aiPositionY = (Integer) serviceResponse.get("aiPositionY");
        Boolean gameOver = (Boolean) serviceResponse.get("gameOver");
        Integer winner = (Integer) serviceResponse.get("winner");

        // Lưu nước đi của AI vào bảng Move
        Move aiMoveEntity = new Move();

        aiMoveEntity.setId(UUID.randomUUID().toString().substring(0, 10));
        aiMoveEntity.setGame(game);
        aiMoveEntity.setPositionX(aiPositionX);
        aiMoveEntity.setPositionY(aiPositionY);
        aiMoveEntity.setColor("WHITE"); //AI mặc định trăắng



        //Cập nhật trạng thái của Game nếu AI nhận thua
        if (gameOver != null && gameOver ) {
            game.setEndDateTime(new Date());
            gameRepository.save(game);
            if (aiPositionX == null && aiPositionY == null){
                aiMoveEntity.setPositionX(99999);
                aiMoveEntity.setPositionY(99999);
            }


        }

        moveRepository.save(aiMoveEntity);

        System.out.println(aiMoveEntity);
        //Trả về res của AI
        return aiMoveEntity;
    }

    //Cập nhật lại Game khi kết thúc
    public void endGame(String gameId, String userId, String winner, int scoreBlack, int scoreWhite) {
        Game game = gameRepository.findById(gameId).orElseThrow();
        GameParticipant userParticipant = gameParticipantRepository.findByGameIdAndUserId(gameId, userId);
        if (userParticipant == null) {
            throw new IllegalStateException("GameParticipant not found for gameId: " + gameId + " and userId: " + userId);
        }
        AIParticipant aiParticipant = aiParticipantRepository.findByGameId(gameId);
        if (aiParticipant == null) {
            throw new IllegalStateException("AIParticipant not found for gameId: " + gameId);
        }

        // Cập nhật điểm của màu tương ứng trong bảng Game
        game.setScoreBlack(scoreBlack);
        game.setScoreWhite(scoreWhite);
        gameRepository.save(game);

        // Cập nhật kết quả trong bảng GameParticipant và AIParticipant
        userParticipant.setResult(winner.equals("USER") ? "WIN" : (winner.equals("DRAW") ? "DRAW" : "LOSE")); //WIN nếu User thắng, và ngược lại
        aiParticipant.setResult(winner.equals("AI") ? "WIN" : (winner.equals("DRAW") ? "DRAW" : "LOSE"));
        gameParticipantRepository.save(userParticipant);
        aiParticipantRepository.save(aiParticipant);

        //Tạo result trả về
//        Map<String, Object> result = new HashMap<>();
//        result.put("winner", winner);
//        result.put("scoreBlack", game.getScoreBlack());
//        result.put("scoreWhite", game.getScoreWhite());

    }



    //Hàm xử lý chơi lại
    public Game replayGame(String gameId) {
        // Lấy AIModel và User từ ván cũ
        Game oldGame = gameRepository.findById(gameId).orElseThrow();
        AIParticipant aiParticipant = aiParticipantRepository.findByGameId(gameId);
        GameParticipant userParticipant = gameParticipantRepository.findByGameId(gameId);

        // Tạo ván mới với cùng AIModel và userId
        return startGame(aiParticipant.getAiModel().getId(), userParticipant.getUser().getId());
    }
}