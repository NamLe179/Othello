"use client"

import { useState } from "react"
import { getLeaderboard } from "../api/api"
import "./Leaderboard.css"

// bộ lọc chế độ chơi
enum GameMode {
  EASY = "EASY",
  HARD = "HARD",
  PVP = "PvP",
}

// bộ lọc thời gian
enum TimeRange {
  WEEK = "WEEK",
  MONTH = "MONTH",
  ALL = "ALL",
}

// cấu trúc BXH
interface LeaderboardEntry {
  id: string;
  userName: string;
  wins: number;
  rank: number;
}

const Leaderboard = () => {
  const [gameMode, setGameMode] = useState<GameMode>(GameMode.EASY)
  const [timeRange, setTimeRange] = useState<TimeRange>(TimeRange.WEEK)
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([]) // ds người chơi từ api
  const [loading, setLoading] = useState(false)
  const [showLeaderboard, setShowLeaderboard] = useState(false) 

  // GỌi api lấy BXH
  const fetchLeaderboard = async () => {
    setLoading(true);
    try {
      // lấy dữ liệu chế độ, thời gian từ người dùng
      const difficulty = gameMode === GameMode.EASY ? "EASY" : gameMode === GameMode.HARD ? "HARD" : undefined;
      const gameType = gameMode === GameMode.PVP ? "PvP" : `PvE_${difficulty}`;
      const response = await getLeaderboard(gameType, timeRange);
      const data = response.data.map((user: any, index: number) => ({
        id: user.id,
        userName: user.userName,
        wins: user.wins || 0, 
        rank: index + 1,
      }));
      setLeaderboard(data);
      setShowLeaderboard(true);
    } catch (error) {
      console.error("Failed to fetch leaderboard:", error);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="leaderboard-container">
      <h2>Bảng xếp hạng của người chơi</h2>

      <div className="leaderboard-filters">
        <div className="filter-card">
          <h3>Chọn bộ lọc</h3>

          <div className="filter-group">
            <label>Chế độ chơi:</label>
            <div className="filter-options">
              <button
                className={`filter-btn ${gameMode === GameMode.EASY ? "active" : ""}`}
                onClick={() => setGameMode(GameMode.EASY)}
              >
                Dễ
              </button>
              <button
                className={`filter-btn ${gameMode === GameMode.HARD ? "active" : ""}`}
                onClick={() => setGameMode(GameMode.HARD)}
              >
                Khó
              </button>
              {/* <button
                className={`filter-btn ${gameMode === GameMode.PVP ? "active" : ""}`}
                onClick={() => setGameMode(GameMode.PVP)}
              >
                PvP
              </button> */}
            </div>
          </div>

          <div className="filter-group">
            <label>Chọn khoảng thời gian:</label>
            <div className="filter-options">
              <button
                className={`filter-btn ${timeRange === TimeRange.WEEK ? "active" : ""}`}
                onClick={() => setTimeRange(TimeRange.WEEK)}
              >
                Tuần này
              </button>
              <button
                className={`filter-btn ${timeRange === TimeRange.MONTH ? "active" : ""}`}
                onClick={() => setTimeRange(TimeRange.MONTH)}
              >
                Tháng này
              </button>
              <button
                className={`filter-btn ${timeRange === TimeRange.ALL ? "active" : ""}`}
                onClick={() => setTimeRange(TimeRange.ALL)}
              >
                Tất cả
              </button>
            </div>
          </div>

          <button className="btn btn-primary view-btn" onClick={fetchLeaderboard} disabled={loading}>
            {loading ? "Loading..." : "Xem Bảng xếp hạng"}
          </button>
        </div>
      </div>

      {/* Giao diện cập nhật lại sau khi chọn thời gian và chế độ */}
      {showLeaderboard && (
        <div className="leaderboard-results">
          <h3>
            {gameMode === GameMode.EASY ? "Chế độ: Dễ" : gameMode === GameMode.HARD ? "Chế độ: Khó" : "Chế độ PvP"} -
            {timeRange === TimeRange.WEEK ? " Tuần này" : timeRange === TimeRange.MONTH ? "Tháng này" : "Tất cả"}
          </h3>

          <div className="leaderboard-table-container">
            <table className="leaderboard-table">
              <thead>
                <tr>
                  <th>Xếp hạng</th>
                  <th>Người chơi</th>
                  <th>Số trận thắng</th>
                </tr>
              </thead>
              <tbody>
                {leaderboard.map((entry) => (
                  <tr key={entry.id}>
                    <td>{entry.rank}</td>
                    <td>{entry.userName}</td>
                    <td>{entry.wins}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  )
}

export default Leaderboard