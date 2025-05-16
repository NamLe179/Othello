import { createContext, useState, useContext, useEffect, type ReactNode } from "react"
import { login as loginApi, register as registerApi } from "../api/api"

// Định nghĩa User theo BE
interface User {
  id: string
  userName: string
  email: string
}

// Định nghĩa giá trị 
interface AuthContextType {
  user: User | null
  isAuthenticated: boolean
  login: (username: string, password: string) => Promise<boolean>
  register: (username: string, email: string, password: string) => Promise<boolean>
  logout: () => void
}

// Tạo context luu xác thực
const AuthContext = createContext<AuthContextType | undefined>(undefined)

// tùy chỉnh để truy cập context
export const useAuth = () => {
  const context = useContext(AuthContext)
  if (context === undefined) {
    throw new Error("useAuth must be used within an AuthProvider")
  }
  return context
}

interface AuthProviderProps {
  children: ReactNode
}

export const AuthProvider = ({ children }: AuthProviderProps) => {
  const [user, setUser] = useState<User | null>(null) // Lưu thông tin người dùng
  const [isAuthenticated, setIsAuthenticated] = useState(false) //lưu trạng thái xác thực

  useEffect(() => {
    const storedUser = localStorage.getItem("user") // Kiểm tra local storage lấy thông tin người dùng đã lưu
    if (storedUser) {
      setUser(JSON.parse(storedUser))
      setIsAuthenticated(true)
    }
  }, [])

  // Gọi login api yêu cầu đăng nhập
  const login = async (username: string, password: string): Promise<boolean> => {
    try {
      const response = await loginApi(username, password);
      const userData = response.data;
      setUser(userData);
      setIsAuthenticated(true);
      localStorage.setItem("user", JSON.stringify(userData)); // Lưu vào local nếu oke
      return true;
    } catch (error) {
      console.error("Login failed:", error);
      return false;
    }
  }

  // Gọi register yêu cầu đăng ký
  const register = async (username: string, email: string, password: string): Promise<boolean> => {
    try {
      const response = await registerApi(username, email, password);
      const userData = response.data;
      setUser(userData);
      setIsAuthenticated(true);
      localStorage.setItem("user", JSON.stringify(userData)); // Lưu vào local nếu oke
      return true;
    } catch (error) {
      console.error("Registration failed:", error);
      return false;
    }
  }

  const logout = () => {
    setUser(null)
    setIsAuthenticated(false)
    localStorage.removeItem("user")
  }

  // Provider cung cấp context cho cả App
  return (
    <AuthContext.Provider value={{ user, isAuthenticated, login, register, logout }}>
      {children}
    </AuthContext.Provider>
  )
}