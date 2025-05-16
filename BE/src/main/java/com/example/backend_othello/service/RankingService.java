package com.example.backend_othello.service;

import com.example.backend_othello.entity.TKUser;
import com.example.backend_othello.repository.GameParticipantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class RankingService {
    @Autowired
    private GameParticipantRepository gameParticipantRepository;

    //Xử lý thống kê
    public List<TKUser> getRankings(String gameType, String timeRange) {
        Date startDate;
        Date endDate = new Date(); // Mặc định là hiện tại
        Calendar calendar = Calendar.getInstance();

        //Xác định ngày bắt đầu theo timeRange
        switch (timeRange.toUpperCase()) {
            case "WEEK":
                calendar.add(Calendar.WEEK_OF_YEAR, -1);
                startDate = calendar.getTime();
                break;
            case "MONTH":
                calendar.add(Calendar.MONTH, -1);
                startDate = calendar.getTime();
                break;
            case "ALL":
            default:
                startDate = new Date(0); 
                endDate = null;
                break;
        }

        //Gọi hàm lấy ds TKUser tương ứng thời gian và chế độ rồi trả về
        return gameParticipantRepository.getRankingsByGameTypeAndDate(gameType, startDate, endDate);
    }
}
