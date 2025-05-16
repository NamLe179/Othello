"use client"

import type React from "react"

import { useState } from "react"
import { useNavigate, Link } from "react-router-dom"
import { useAuth } from "../context/AuthContext"
import "./Auth.css"

const Login = () => {
  const [username, setUsername] = useState("")
  const [password, setPassword] = useState("")
  const [error, setError] = useState("")
  const [loading, setLoading] = useState(false)

  const { login } = useAuth()
  const navigate = useNavigate()

  // Xử lý gọi api sau khi ấn login
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()

    if (!username || !password) {
      setError("Xin vui lòng điền đầy đủ thông tin")
      return
    }

    try {
      setError("")
      setLoading(true)

      const success = await login(username, password)

      if (success) {
        navigate("/")
      } else {
        setError("Tên đăng nhập hoặc mật khẩu không chính xác")
      }
    } catch (err: any) {
      if (err.response && err.response.data && err.response.data.message) {
        setError(err.response.data.message)
      } else {
        setError("Đã có lỗi xảy ra trong quá trình đăng nhập")
      }
      console.error("Login error:", err)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="auth-container">
      <div className="auth-card">
        <h2>Đăng nhập để tiếp tục</h2>

        {error && <div className="auth-error">{error}</div>}

        <form onSubmit={handleSubmit} className="auth-form">
          <div className="form-group">
            <label htmlFor="username">Tên đăng nhập</label>
            <input
              type="text"
              id="username"
              className="form-control"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="password">Mật khẩu</label>
            <input
              type="password"
              id="password"
              className="form-control"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>

          <button type="submit" className="btn btn-primary auth-button" disabled={loading}>
            {loading ? "Đang tải..." : "Đăng nhập"}
          </button>
        </form>

        <div className="auth-footer">
          <p>
            Bạn không có tài khoản? <Link to="/register">Đăng kí ngay</Link>
          </p>
        </div>
      </div>
    </div>
  )
}

export default Login