"use client"

import { Link } from "react-router-dom"
import { useAuth } from "../context/AuthContext"
import "./Navbar.css"

const Navbar = () => {
  const { isAuthenticated, logout } = useAuth()

  return (
    <nav className="navbar">
      <div className="navbar-container">
        <Link to="/" className="navbar-logo">
          Othello Game
        </Link>
        <ul className="navbar-menu">
          <li className="navbar-item">
            <Link to="/" className="navbar-link">
              Trang chủ
            </Link>
          </li>
          {isAuthenticated ? (
            <>
              <li className="navbar-item">
                <Link to="/game" className="navbar-link">
                  Chơi
                </Link>
              </li>
              <li className="navbar-item">
                <Link to="/leaderboard" className="navbar-link">
                  BXH
                </Link>
              </li>
              <li className="navbar-item">
                <button onClick={logout} className="navbar-button">
                  Đăng xuất
                </button>
              </li>
            </>
          ) : (
            <>
              <li className="navbar-item">
                <Link to="/login" className="navbar-link">
                  Login
                </Link>
              </li>
              <li className="navbar-item">
                <Link to="/register" className="navbar-link">
                  Register
                </Link>
              </li>
            </>
          )}
        </ul>
      </div>
    </nav>
  )
}

export default Navbar
