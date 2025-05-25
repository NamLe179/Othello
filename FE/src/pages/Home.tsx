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

      
    </div>
  )
}

export default Home