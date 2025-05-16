import numpy as np #DÙng để xử lý mảng
import tensorflow as tf #Tải và dùng mô hình học sâu
from tensorflow import keras
from fastapi import FastAPI, HTTPException, Request #Xây dựng API và xác thực input
from pydantic import BaseModel, ValidationError, Field
import logging #Debug
from typing import List, Tuple, Optional

# Thiết lập logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

# Lớp Othello để quản lý trò chơi
class Othello:
    def __init__(self, board=None, current_player=-1):
        #Khởi tạo bàn cờ 8x8 
        if board is None:
            self.board = np.zeros((8, 8), dtype=int)
            self.board[3, 3] = 1  # Trắng
            self.board[3, 4] = -1 # Đen
            self.board[4, 3] = -1 # Đen
            self.board[4, 4] = 1  # Trắng
        else:
            self.board = np.array(board, dtype=int)
        self.current_player = current_player
        self.consecutive_passes = 0  # Theo dõi số lần pass liên tiếp của AI
        self.max_consecutive_passes = 5  # Ngưỡng pass tối đa trước khi AI nhận thua
        self.last_passed_by_ai = False  # Kiểm tra xem pass cuối cùng có phải do AI không

    #Kiểm tra xem nước đi có hợp lệ không
    def is_valid_move(self, move):
        x, y = move
        if not (0 <= x < 8 and 0 <= y < 8) or self.board[x, y] != 0:
            return False #Validate
        directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)] #Các hướng có thể đi
        #TÌm kiếm theo hướng
        for dx, dy in directions:
            nx, ny = x + dx, y + dy
            if 0 <= nx < 8 and 0 <= ny < 8 and self.board[nx, ny] == -self.current_player:
                while 0 <= nx < 8 and 0 <= ny < 8 and self.board[nx, ny] == -self.current_player:
                    nx += dx
                    ny += dy
                if 0 <= nx < 8 and 0 <= ny < 8 and self.board[nx, ny] == self.current_player:
                    return True #Hợp lệ khi có nước đi trắng đối diện
        return False #Không hợp lệ nếu ko có đối diện

    #Hàm thực hiện nước đi
    def make_move(self, move):
        x, y = move
        if not self.is_valid_move(move): #Kiểm tra valid
            return False, []
        self.board[x, y] = self.current_player
        directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        flipped = [] #Ds đã lật
        for dx, dy in directions: #TÌm kiếm theo từng hướng
            nx, ny = x + dx, y + dy
            to_flip = [] #Ds quân dự định bị lật
            if 0 <= nx < 8 and 0 <= ny < 8 and self.board[nx, ny] == -self.current_player:
                to_flip.append((nx, ny)) #Nếu nước đi hợp lệ đưa quân dối thủ vào ds có thể lật
                while 0 <= nx < 8 and 0 <= ny < 8 and self.board[nx, ny] == -self.current_player:
                    nx += dx
                    ny += dy
                    if 0 <= nx < 8 and 0 <= ny < 8:
                        to_flip.append((nx, ny)) #Thêm vào cho đến khi gặp quân mình
                if 0 <= nx < 8 and 0 <= ny < 8 and self.board[nx, ny] == self.current_player:
                    for fx, fy in to_flip:
                        self.board[fx, fy] = self.current_player #lật quân
                        flipped.append([fx, fy]) #thêm vào ds đã lật
        self.current_player = -self.current_player #Đổi lượt cho đối thủ
        self.consecutive_passes = 0  # Reset số lần pass liên tiếp khi có nước đi hợp lệ
        self.last_passed_by_ai = False  # Reset trạng thái pass
        return True, flipped
    
    #Chuyển lượt khi ko tìm thấy nước đi hợp lệ, tăng số lần pass
    def pass_turn(self):
        self.current_player = -self.current_player
        if self.current_player == 1:  # Nếu là lượt của AI (Trắng)
            self.consecutive_passes += 1
            self.last_passed_by_ai = True
            logger.info(f"AI passes turn. Consecutive passes: {self.consecutive_passes}")
        elif self.last_passed_by_ai:  # Nếu lần pass trước là của AI và bây giờ người chơi pass
            self.consecutive_passes += 1
            logger.info(f"Player passes turn after AI. Consecutive passes (counted for AI): {self.consecutive_passes}")
        else:
            self.consecutive_passes = 0  # Reset nếu người chơi pass mà trước đó không có pass từ AI
            self.last_passed_by_ai = False
            logger.info("Player passes turn. Reset consecutive passes.")

    #Kiểm tra nếu AI pass quá 5 lần, so sánh số quân cờ để xác định thắng/thua.
    def check_ai_surrender(self):
        if self.consecutive_passes >= self.max_consecutive_passes:
            white = np.sum(self.board == 1)  # Số quân cờ trắng (AI)
            black = np.sum(self.board == -1)  # Số quân cờ đen (người chơi)
            logger.info(f"AI consecutive passes reached {self.consecutive_passes}. White: {white}, Black: {black}")
            if white < black:
                logger.info("AI surrenders: White pieces less than Black")
                return True, -1  # Người chơi (Đen) thắng
            elif white > black:
                logger.info("AI wins: White pieces more than Black")
                return True, 1  # AI (Trắng) thắng
            else:
                logger.info("Draw: White pieces equal to Black")
                return True, 0  # Hòa
        return False, 0

    #Lấy ds nước đi hợp lệ
    def get_valid_moves(self):
        valid_moves = []
        for x in range(8):
            for y in range(8):
                if self.is_valid_move((x, y)):
                    valid_moves.append([x, y]) #Thêm vào ds tại các hướng
        return valid_moves

    #Kiểm tra trò chơi kết thúc khi bàn cờ đầy
    def is_game_over(self):
        return np.count_nonzero(self.board == 0) == 0 #Đếm nước bằng 0 (trống)

    #Xác định người thắng
    def get_winner(self):
        white = np.sum(self.board == 1)
        black = np.sum(self.board == -1)
        surrender, result = self.check_ai_surrender()
        if surrender:
            return result
        if white > black:
            return 1
        elif black > white:
            return -1
        return 0

    def get_state(self):
        return self.board.copy()

# Lớp MCTS sử dụng trong model
class MCTS:
    def __init__(self, model, simulations=50): #Nạp vào model và số lần mô phỏng
        self.model = model
        self.simulations = simulations
        self.Q = {} #giá trị trung bình
        self.N = {} #Số lần thăm
        self.P = {} #Xác suất ban đầu

    #TÌm nước đi tốt nhất 
    def search(self, game):
        root_state = tuple(map(tuple, game.get_state())) #Nạp trạng thái ban đầu
        valid_moves = game.get_valid_moves()
        if not valid_moves:
            return None #Kiểm tra có nước đi hợp lệ ko
        for _ in range(self.simulations):
            state = game.get_state().copy() #DÙng bản sao của game để mô phỏng
            current_game = Othello(board=state, current_player=game.current_player)
            self.simulate(current_game, root_state)
        best_move = max(valid_moves, key=lambda move: self.N.get((root_state, tuple(move)), 0)) #Chọn nước đi có số lần thăm cao nhất
        return best_move

    #Hàm mô phỏng
    def simulate(self, game, root_state):
        state = tuple(map(tuple, game.get_state()))
        valid_moves = game.get_valid_moves()
        if not valid_moves:
            return game.get_winner() #Kiểm tra có nước đi hợp lệ ko
        if state not in self.P:
            board = np.expand_dims(game.get_state(), axis=(0, -1))
            value = self.model.predict(board, verbose=0)[0][0] #Sử dụng model để dự đoán giá trị trạng thái bàn cờ
            self.P[state] = {tuple(move): 1/len(valid_moves) for move in valid_moves} #Cập nhật xác suất
            return value
        move = max(valid_moves, key=lambda m: self.ucb_score(state, m)) #Lấy nước đi có Upper Confidence Bound/Giới hạn tin cậy trên/ cao nhất
        game.make_move(move) #Chọn nước đi trong mô phỏng
        value = self.simulate(game, root_state) 
        s_m = (state, tuple(move))
        self.Q[s_m] = self.Q.get(s_m, 0) + value #Cập nhật giá trị trung bình và số lần thăm sau mô phỏng 
        self.N[s_m] = self.N.get(s_m, 0) + 1
        return value

    #Hàm tính điểm UCB để chọn nước đi trong mô phỏng
    def ucb_score(self, state, move):
        Q = self.Q.get((state, tuple(move)), 0) 
        N = self.N.get((state, tuple(move)), 0)
        P = self.P[state][tuple(move)]
        N_parent = sum(self.N.get((state, m), 0) for m in self.P[state])
        return Q / (N + 1) + 1.41 * P * np.sqrt(N_parent) / (1 + N)

# Hàm chuyển đổi tọa độ thành list và ngược lại
def coords_to_list(position_x: Optional[int], position_y: Optional[int]) -> Optional[List[int]]:
    if position_x is not None and position_y is not None:
        return [position_x, position_y]
    return None

def list_to_coords(move: Optional[List[int]]) -> tuple[Optional[int], Optional[int]]:
    if move is not None and len(move) == 2:
        return move[0], move[1]
    return None, None

# Tải mô hình
try:
    model = keras.models.load_model('othello_model_hard.keras')
except Exception as e:
    logger.error(f"Failed to load model: {str(e)}")
    raise Exception(f"Failed to load model: {str(e)}")

# Khởi tạo trò chơi Othello bên phía service, bắt đầu với lượt của Đen
game = Othello(current_player=-1)

# Định nghĩa request/response của models
class MoveRequest(BaseModel):
    positionX: Optional[int] = Field(None, alias="positionX", ge=0, le=7)
    positionY: Optional[int] = Field(None, alias="positionY", ge=0, le=7)
    
    class Config:
        populate_by_name = True

class MoveResponse(BaseModel):
    aiPositionX: Optional[int] = Field(None, alias="aiPositionX")
    aiPositionY: Optional[int] = Field(None, alias="aiPositionY")
    flipped: List[List[int]]
    gameOver: bool = Field(..., alias="gameOver")
    winner: int

    class Config:
        populate_by_name = True

# class ValidMovesRequest(BaseModel):
#     board: List[List[int]]
#     current_player: int = Field(..., alias="currentPlayer")

#     class Config:
#         populate_by_name = True

# class ValidMovesResponse(BaseModel):
#     valid_moves: List[List[int]] = Field(..., alias="validMoves")

#     class Config:
#         populate_by_name = True

#API xử lý nước đi của người chơi và trả về
@app.post("/play", response_model=MoveResponse)
async def play_move(request: MoveRequest):
    try:
        global game

        #Đặt lượt chơi của người chơi là Đen 
        game.current_player = -1

        #Chuyển đổi tọa độ người chơi thành list
        player_move = coords_to_list(request.positionX, request.positionY)

        #Xử lý nước đi của người chơi 
        flipped = []
        if player_move:
            if not game.is_valid_move(player_move): #Kiểm tra valid
                raise HTTPException(status_code=400, detail="Invalid player move")
            success, flipped = game.make_move(player_move) #Thực hiện nước đi và lưu quân đã lật
            if not success:
                raise HTTPException(status_code=400, detail="Failed to execute player move")
            logger.info(f"Player move at {player_move}, flipped: {flipped}")
        else:
            #Nếu người chơi pass, chuyển lượt
            game.pass_turn()

        #Kiểm tra nếu trò chơi kết thúc hoặc AI đạt điều kiện thắng/thua do pass
        surrender, _ = game.check_ai_surrender()
        if game.is_game_over() or surrender:
            return MoveResponse(
                aiPositionX=None,
                aiPositionY=None,
                flipped=[],
                gameOver=True,
                winner=game.get_winner()
            )

        #AI chọn nước đi
        mcts = MCTS(model)
        ai_move = mcts.search(game) #TÌm nước đi tối ưu
        if ai_move:
            success, flipped = game.make_move(ai_move) #Thực hiện nước đi và lưu quân đã lật
            if not success:
                raise HTTPException(status_code=500, detail="AI failed to make a valid move") 
            logger.info(f"AI move at {ai_move}, flipped: {flipped}")
            ai_position_x, ai_position_y = list_to_coords(ai_move) #Chuyển list thành tọa độ
            return MoveResponse(
                aiPositionX=ai_position_x,
                aiPositionY=ai_position_y,
                flipped=flipped,
                gameOver=game.is_game_over(),
                winner=game.get_winner() if game.is_game_over() else 0
            )
        else:
            #Nếu AI không có nước đi hợp lệ, pass lượt
            game.pass_turn()
            #Kiểm tra lại sau khi AI pass
            surrender, _ = game.check_ai_surrender()
            if game.is_game_over() or surrender:
                return MoveResponse(
                    aiPositionX=None,
                    aiPositionY=None,
                    flipped=[],
                    gameOver=True,
                    winner=game.get_winner()
                )
            return MoveResponse(
                aiPositionX=None,
                aiPositionY=None,
                flipped=[],
                gameOver=False,
                winner=0
            )

    except ValidationError as ve:
        logger.error(f"Validation error: {ve.errors()}")
        raise HTTPException(status_code=422, detail=ve.errors())
    except Exception as e:
        logger.error(f"Error processing move: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))

#API xử lý chơi lại bằng cách reset bàn cờ của AI về trạng thái ban đầu
@app.post("/reset")
async def reset_game():
    global game
    game = Othello(current_player=-1)
    logger.info("Game board reset")
    return {"message": "Game reset successfully"}

#Chạy service trên cổng 8000 bằng uvicorn server
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)