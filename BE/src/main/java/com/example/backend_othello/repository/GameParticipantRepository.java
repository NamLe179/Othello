package com.example.backend_othello.repository;

import com.example.backend_othello.entity.AIParticipant;
import com.example.backend_othello.entity.GameParticipant;
import com.example.backend_othello.entity.TKUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface GameParticipantRepository extends JpaRepository<GameParticipant, String> {
//    @Query("SELECT gp FROM GameParticipant gp JOIN gp.game g WHERE g.id = :gameId")
//    GameParticipant findByGameId(@Param("gameId") String gameId);
//
//    GameParticipant findByGameIdAndUserId(String gameId, String userId);

    //Truy vấn xếp hạng người chơi theo số trận thắng, thời gian
    //Tạo ds TKUser từ truy vấn với thông tin User từ bảng User, input và hàm đếm
    @Query("SELECT new com.example.backend_othello.entity.TKUser(u.id, u.userName, u.email, :startDate, :endDate, :gameType, COUNT(gp)) " +
            "FROM GameParticipant gp " +
            "JOIN Game g ON g.gameParticipant.id = gp.id " +
            "JOIN gp.user u " +
            "WHERE gp.result = 'WIN' " +
            "AND g.gameType = :gameType " +
            "AND g.startDateTime >= :startDate " +
            "AND (g.endDateTime <= :endDate OR :endDate IS NULL) " +
            "GROUP BY u.id, u.userName, u.email " +
            "ORDER BY COUNT(gp) DESC")
    List<TKUser> getRankingsByGameTypeAndDate(
            @Param("gameType") String gameType,
            @Param("startDate") Date startDate,
            @Param("endDate") Date endDate);
}