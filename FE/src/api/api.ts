import axios from 'axios';

// Tạo instance của Axios với url BE và dữ liệu là json
const API_BASE_URL = 'http://localhost:8080/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Đăng nhập
export const login = async (username: string, password: string) => {
  return api.post('/users/login', { userName: username, passWord: password });
};

// Đăng ký
export const register = async (username: string, email: string, password: string) => {
  return api.post('/users/register', { userName: username, email, passWord: password });
};

// Lấy danh sách AIModel
export const getAIModels = async () => {
  return api.get('/game/ai-models');
};

// Bắt đầu game
export const startGame = async (aiModelId: string, userId: string) => {
  return api.post(`/game/start?aiModelId=${aiModelId}&userId=${userId}`);
};

// Gửi nước đi hoặc pass
export const makeMove = async (move: { gameId: string; positionX?: number; positionY?: number; color?: string}) => {
  return api.post('/game/move', move);
};

// Kết thúc game
export const endGame = async (gameId: string, userId: string, winner: string, scoreBlack: number, scoreWhite: number) => {
  return api.post(`/game/end?gameId=${gameId}&userId=${userId}&winner=${winner}&scoreBlack=${scoreBlack}&scoreWhite=${scoreWhite}`);
};

// Chơi lại game
export const replayGame = async (gameId: string) => {
  return api.post(`/game/replay?gameId=${gameId}`);
};

// Lấy bảng xếp hạng
export const getLeaderboard = async (gameType: string, timeRange: string) => {
  return api.get(`/rankings?gameType=${gameType}&timeRange=${timeRange}`);
};