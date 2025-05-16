"use client"

import { Link } from "react-router-dom"
import { useAuth } from "../context/AuthContext"
import "./Home.css"

const Home = () => {
  const { isAuthenticated, user } = useAuth() //Kiểm tra đăng nhập

  return (
    <div className="home-container">
      <div className="home-hero">
        <h1>OTHELLO - REVERSI</h1>
        <p className="home-subtitle">Chơi cờ Othello online</p>

        {isAuthenticated && user ? (
          <div className="home-welcome">
            {/* HIển thị lời chào sau khi dăng nhập */}
            {/* <h2>Xin chào, {user.userName}!</h2> */}
            <div className="home-buttons">
              <Link to="/game" className="btn btn-primary">
                Chơi 
              </Link>
              <Link to="/leaderboard" className="btn btn-secondary">
                Xem BXH
              </Link>
            </div>
          </div>
        ) : (
          <div className="home-auth">
            {/* HIển thị đăng nhập nếu chưa */}
            <p>Đăng nhập để bắt đầu</p>
            <div className="home-buttons">
              <Link to="/login" className="btn btn-primary">
                Đăng nhập
              </Link>
              <Link to="/register" className="btn btn-secondary">
                Đăng ký  
              </Link>
            </div>
          </div>
        )}
      </div>

      {/* <div className="home-features">
        <div className="feature-card">
          <h3>Đánh với máy</h3>
          <p>Đánh với máy cùng nhiều độ khó khác nhau</p>
        </div>
        
        <div className="feature-card">
          <h3>Xem Bảng xếp hạng</h3>
          <p>Xem thứ hạng của mình và của người chơi khác</p>
        </div>
      </div> */}

      {/* <div className="home-rules">
        <h2>Hướng dẫn chơi Othello</h2>
        <div className="rules-content">
          <div className="rules-text">
            <p>Bàn cờ được chia thành lưới ô vuông 8x8. Trò chơi bắt đầu với 4 quân cờ đặt sẵn ở giữa:</p>
            <ul>
              <li>2 quân đen đặt theo đường chéo</li>
              <li>2 quân trắng cũng được đặt tương tự</li>
            </ul>
            <p>Luật chơi cờ Othello:</p>
            <ul>
              <li>Quân đen mặc định được đi trước</li>
              <li>1 nước đi hợp lệ là nước đi phải lật được ít nhất 1 quân của dối thủ</li>
              <li>Lật quân đối thủ khi quân của bạn bao quanh quân đối thủ theo đường thẳng</li>
              <li>Những quân bị lật sẽ đổi thành màu của quân bạn</li>
              <li>Nếu người chơi không có nước đi hợp lệ, hãy chuyển lượt cho đối thủ</li>
              <li>Trò chơi sẽ kết thúc khi cả 2 không còn nước đi hợp lệ</li>
              <li>Người nào có nhiều quân cờ hơn sẽ giành chiến thắng</li>
            </ul>
          </div>
          <div className="rules-image">
            <div className="board-preview"></div>
          </div>
        </div>
      </div> */}
    </div>
  )
}

export default Home