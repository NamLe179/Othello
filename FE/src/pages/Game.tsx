"use client"

import { useState, useEffect } from "react"
import { useNavigate } from "react-router-dom"
import { useAuth } from "../context/AuthContext"
import { getAIModels, startGame, makeMove, endGame, replayGame } from "../api/api"
import "./Game.css"

// Định nghĩa độ khó
enum Difficulty {
  EASY = "EASY",
  HARD = "HARD",
}

// Định nghĩa trạng thái game
enum GameState {
  SETUP = "setup",
  PLAYING = "playing",
  FINISHED = "finished",
}

// ĐỊnh nghĩa quân cờ
enum Disc {
  EMPTY = 0,
  BLACK = 1,
  WHITE = 2,
}

interface AIModel {
  id: string;
  name: string;
  difficulty: string;
  createAt: string;
  serviceUrl: string;
}

// tương ứng với Game BE
interface GameData {
  id: string;
  startTime: string;
  endTime?: string;
  scoreWhite?: number;
  scoreBlack?: number;
  gameType: string;
  aiParticipantId: string;
}

// res sau khi gọi api
interface MoveResponse {
  gameId: string;
  positionX: number | null; 
  positionY: number | null; 
  color: string;
  id?: string; 
  // winner: number;
}

const Game = () => {
  const { user } = useAuth()
  const navigate = useNavigate()

  // Khởi tạo Game
  const [difficulty, setDifficulty] = useState<Difficulty>(Difficulty.EASY) 
  const [gameState, setGameState] = useState<GameState>(GameState.SETUP)
  const [aiModels, setAIModels] = useState<AIModel[]>([]) //Lưu ds model AI từ api
  const [selectedAIModel, setSelectedAIModel] = useState<AIModel | null>(null) // lưu model AI đc chọn
  const [game, setGame] = useState<GameData | null>(null) 

  // Khởi tạo trạng thái
  const [board, setBoard] = useState<Disc[][]>([]) 
  const [currentPlayer, setCurrentPlayer] = useState<Disc>(Disc.BLACK) // lưu người chơi
  const [scores, setScores] = useState({ black: 2, white: 2 })  
  const [validMoves, setValidMoves] = useState<[number, number][]>([]) // lưu ds nước đi hợp lệ để hiển thị
  const [gameResult, setGameResult] = useState<string>("")
  const [hasValidMove, setHasValidMove] = useState<boolean>(true) // kiểm tra có nước đi hợp lệ ko
  const [isProcessing, setIsProcessing] = useState<boolean>(false) // Thêm trạng thái để theo dõi xử lý nước đi

  // Khởi tạo bàn cờ 8x8
  const initializeBoard = () => {
    const newBoard: Disc[][] = Array(8)
      .fill(null)
      .map(() => Array(8).fill(Disc.EMPTY))

    newBoard[3][3] = Disc.WHITE
    newBoard[3][4] = Disc.BLACK
    newBoard[4][3] = Disc.BLACK
    newBoard[4][4] = Disc.WHITE

    return newBoard
  }

  // Kiểm tra nước đi hợp lệ
  const isValidMove = (board: Disc[][], row: number, col: number, player: Disc): boolean => {
    // validat ô trống
    if (board[row][col] !== Disc.EMPTY) {
      return false
    }

    const opponent = player === Disc.BLACK ? Disc.WHITE : Disc.BLACK
    let isValid = false

    const directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],         [0, 1],
      [1, -1],  [1, 0],  [1, 1],
    ]

    // Kiểm tra có thể lật quân đối thủ ở hướng bất kì ko
    for (const [dx, dy] of directions) {
      let r = row + dx
      let c = col + dy
      let hasOpponentDisc = false

      while (r >= 0 && r < 8 && c >= 0 && c < 8 && board[r][c] === opponent) {
        r += dx
        c += dy
        hasOpponentDisc = true
      }

      if (hasOpponentDisc && r >= 0 && r < 8 && c >= 0 && c < 8 && board[r][c] === player) {
        isValid = true
        break
      }
    }

    return isValid
  }

  // TÌm tất cả nước đi hợp lệ để hiển thị
  const findValidMoves = (board: Disc[][], player: Disc): [number, number][] => {
    const moves: [number, number][] = []

    for (let row = 0; row < 8; row++) {
      for (let col = 0; col < 8; col++) {
        if (isValidMove(board, row, col, player)) {
          moves.push([row, col])
        }
      }
    }

    return moves
  }

  // Lật quân sau mỗi lượt đi
  const flipDiscs = (board: Disc[][], row: number, col: number, player: Disc): Disc[][] => {
    
    
    
    const newBoard = board.map(row => [...row]);
    newBoard[row][col] = player;

    // Lấy người chơi hiện tại
    const opponent = player === Disc.BLACK  ? Disc.WHITE : Disc.BLACK;
    const directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],         [0, 1],
      [1, -1],  [1, 0],  [1, 1],
    ];

    for (const [dx, dy] of directions) {
      let r = row + dx;
      let c = col + dy;
      const discsToFlip: [number, number][] = [];

      // Lật quân theo mọi hướng
      while (r >= 0 && r < 8 && c >= 0 && c < 8 && newBoard[r][c] === opponent) {
        discsToFlip.push([r, c]);
        r += dx;
        c += dy;
      }

      if (r >= 0 && r < 8 && c >= 0 && c < 8 && newBoard[r][c] === player && discsToFlip.length > 0) {
        for (const [flipRow, flipCol] of discsToFlip) {
          newBoard[flipRow][flipCol] = player;
        }
      }
    }

    console.log(`Flipped board for player ${player} at (${row}, ${col}):`, newBoard)
    return newBoard;
  }

  // Tính điểm
  const calculateScores = (board: Disc[][]): { black: number; white: number } => {
    let black = 0;
    let white = 0;

    for (let row = 0; row < 8; row++) {
      for (let col = 0; col < 8; col++) {
        if (board[row][col] === Disc.BLACK) black++;
        else if (board[row][col] === Disc.WHITE) white++;
      }
    }

    return { black, white };
  }

  // Xác định người thắng theo điểm
  const determineWinner = (scores: { black: number; white: number }): string => {
    if (scores.black > scores.white) {
      return "USER"; // Người chơi thắng
    } else if (scores.white > scores.black) {
      return "AI"; // AI thắng
    } else {
      return "DRAW"; // Hòa
    }
  }

  // GỌi api cập nhật kết quả về BE
  const updateGameResult = async (gameId: string, userId: string, winner: string, scoreBlack: number, scoreWhite: number) => {
    try {
      const response = await endGame(gameId, userId, winner, scoreBlack, scoreWhite);
      return response.data;
    } catch (error) {
      console.error("Failed to update game result:", error);
      throw error;
    }
  }

  // gọi api lấy ds AIModel
  useEffect(() => {
    const fetchAIModels = async () => {
      try {
        const response = await getAIModels();
        setAIModels(response.data);
      } catch (error) {
        console.error("Failed to fetch AI models:", error);
      }
    };

    fetchAIModels();
  }, []);

  // Gọi api bắt đầu chơi với model
  const startGameWithAIModel = async (aiModel: AIModel) => {
    if (!user){
      console.error("User not authenticated!!!");
      return;
    }

    try {
      const response = await startGame(aiModel.id, user.id);
      const newGame = response.data;
      setGame(newGame);
      setSelectedAIModel(aiModel);
      setBoard(initializeBoard());
      setCurrentPlayer(Disc.BLACK);
      setScores({ black: 2, white: 2 });
      setValidMoves(findValidMoves(initializeBoard(), Disc.BLACK));
      setGameState(GameState.PLAYING);
      setGameResult("");
      setHasValidMove(true);
      setIsProcessing(false);
    } catch (error) {
      console.error("Failed to start game:", error);
    }
  }

  // Xử lý người chơi đánh cờ
  const handleCellClick = async (row: number, col: number) => {
    if (gameState !== GameState.PLAYING || currentPlayer !== Disc.BLACK || !game || isProcessing || !user) return;

    if (!validMoves.some(([r, c]) => r === row && c === col)) return;

    // Cập nhật trạng thái ngay lập tức sau khi người chơi thực hiện nước đi
    setIsProcessing(true); // Đang xử lý, không cho phép nhấp tiếp

    // Lật quân cờ, cập nhật điểm
    let newBoard = flipDiscs(board, row, col, Disc.BLACK);
    setBoard(newBoard);
    setScores(calculateScores(newBoard));

    if(scores.black + scores.white === 64){
        setGameState(GameState.FINISHED)
        const winner = determineWinner(scores)
        setGameResult(winner === "USER" ? "Bạn thắng!" : winner === "AI" ? "AI thắng!" : "Hòa!")
        await updateGameResult(game.id, user.id, winner, scores.black, scores.white)
        return
    }

    try {
      const move = {
        gameId: game.id,
        positionX: row,
        positionY: col,
        color: "BLACK",
        // userId: user.id,
      };
      // Gửi dữ liệu qua api, nhận res
      const response = await makeMove(move);
      const moveResponse: MoveResponse   = response.data;

      if (moveResponse.positionX === 99999 && moveResponse.positionY === 99999) {
        // Trò chơi kết thúc, gọi endGame
        setGameState(GameState.FINISHED)
        const winner = determineWinner(scores)
        setGameResult(winner === "USER" ? "Bạn thắng!" : winner === "AI" ? "AI thắng!" : "Hòa!")
        await updateGameResult(game.id, user.id, winner, scores.black, scores.white)
        return
      }

      // Cập nhật lại bàn cờ sau khi nhận res từ BE
      
      if (moveResponse.positionX !== null && moveResponse.positionY !== null) {
        
        newBoard = flipDiscs(newBoard, Number(moveResponse.positionX), Number(moveResponse.positionY), Disc.WHITE)
      }
      

      setBoard(newBoard);

      // Cập nhật lại điểm
      setScores(calculateScores(newBoard));

      // Xử lý nước đi của AI
      // if (moveResponse.aiPositionX !== null && moveResponse.aiPositionY !== null) {
      //   const updatedBoard = flipDiscs(updatedBoard, moveResponse.aiPositionX, moveResponse.aiPositionY, Disc.WHITE);
      //   for (const [flipRow, flipCol] of moveResponse.flipped) {
      //     updatedBoard[flipRow][flipCol] = Disc.WHITE;
      //   }
      //   setBoard(updatedBoard);
      //   setScores(calculateScores(updatedBoard));
      // }

      // Kiểm tra xem AI bỏ cuộc ko
      
      setCurrentPlayer(Disc.BLACK);
      const newValidMoves = findValidMoves(newBoard, Disc.BLACK);
      setValidMoves(newValidMoves);
      setHasValidMove(newValidMoves.length > 0);

      if(scores.black + scores.white === 64){
        setGameState(GameState.FINISHED)
        const winner = determineWinner(scores)
        setGameResult(winner === "USER" ? "Bạn thắng!" : winner === "AI" ? "AI thắng!" : "Hòa!")
        await updateGameResult(game.id, user.id, winner, scores.black, scores.white)
        return
      }
      
    } catch (error) {
      console.error("Failed to make move:", error);
    } finally {
      setIsProcessing(false); // Hoàn tất xử lý
    }
  }

  // Hàm xử lý pass
  const handlePass = async () => {
    if (gameState !== GameState.PLAYING || currentPlayer !== Disc.BLACK || !game || hasValidMove || isProcessing || !user) return;

    setIsProcessing(true);
    
    try {
      // Gửi yêu cầu pass cho BE 
      const move = { gameId: game.id};
      const response = await makeMove(move);
      const moveResponse: MoveResponse  = response.data;

       if (moveResponse.positionX === 99999 && moveResponse.positionY === 99999) {
        // Trò chơi kết thúc, gọi endGame
        setGameState(GameState.FINISHED)
        const winner = determineWinner(scores)
        setGameResult(winner === "USER" ? "Bạn thắng!" : winner === "AI" ? "AI thắng!" : "Hòa!")
        await updateGameResult(game.id, user.id, winner, scores.black, scores.white)
        return
      }

      // XỬ lý nước đi AI
      let updatedBoard = board;
      if (moveResponse.positionX !== null && moveResponse.positionY !== null) {
        
        updatedBoard = flipDiscs(updatedBoard, Number(moveResponse.positionX), Number(moveResponse.positionY), Disc.WHITE)
      }
      setBoard(updatedBoard)
      setScores(calculateScores(updatedBoard))

      //Kiểm tra AI bỏ cuộc
      
      setCurrentPlayer(Disc.BLACK);
      const newValidMoves = findValidMoves(updatedBoard, Disc.BLACK);
      setValidMoves(newValidMoves);
      setHasValidMove(newValidMoves.length > 0);

      if(scores.black + scores.white === 64){
        setGameState(GameState.FINISHED)
        const winner = determineWinner(scores)
        setGameResult(winner === "USER" ? "Bạn thắng!" : winner === "AI" ? "AI thắng!" : "Hòa!")
        await updateGameResult(game.id, user.id, winner, scores.black, scores.white)
        return
      }
    
    } catch (error) {
      console.error("Failed to pass:", error);
    } finally {
      setIsProcessing(false); // Hoàn tất xử lý
    }
  }

  // Xử lý người chơi bỏ cuộc
  const handleSurrender = async () => {
    if (gameState !== GameState.PLAYING || !game || !user) return;

    setGameState(GameState.FINISHED);
    setGameResult("Bạn đã đầu hàng. AI thắng!");
    await updateGameResult(game.id, user.id, "AI", scores.black, scores.white);
  }

  // Xử lý người chơi chơi lại
  const handlePlayAgain = async () => {
    if (!game || !user) return;

    try {
      // GỌi api chơi lại
      const response = await replayGame(game.id);
      const newGame = response.data;
      // cập nhật lại trạng thái bàn cờ
      setGame(newGame);
      setBoard(initializeBoard());
      setCurrentPlayer(Disc.BLACK);
      setScores({ black: 2, white: 2 });
      setValidMoves(findValidMoves(initializeBoard(), Disc.BLACK));
      setGameState(GameState.PLAYING);
      setGameResult("");
      setHasValidMove(true);
      setIsProcessing(false);
    } catch (error) {
      console.error("Failed to replay game:", error);
    }
  }

  // Kiểm tra nước đi hợp lệ
  useEffect(() => {
    if (gameState !== GameState.PLAYING) return;

    // Cập nhật valid move sau khi thay đổi bàn cờ
    const playerValidMoves = findValidMoves(board, Disc.BLACK);
    setValidMoves(playerValidMoves);
    setHasValidMove(playerValidMoves.length > 0);
  }, [board, gameState]);

  return (
    <div className="game-container">
      {gameState === GameState.SETUP && (
        <div className="game-setup">
          <h2>Chơi cờ Othello</h2>
          <div className="setup-card">
            <h3>Chọn độ khó</h3>
            <div className="difficulty-options">
              {/* Fix cứng chọn độ khó sẽ tìm theo AIModel có độ khó giống hệt */}
              <button
                className={`difficulty-btn ${difficulty === Difficulty.EASY ? "active" : ""}`}
                onClick={() => setDifficulty(Difficulty.EASY)}
              >
                Dễ
              </button>
              <button
                className={`difficulty-btn ${difficulty === Difficulty.HARD ? "active" : ""}`}
                onClick={() => setDifficulty(Difficulty.HARD)}
              >
                Khó
              </button>
            </div>
            

            {/* Bắt đầu chơi để gọi api với id tương ứng độ khó đã chọn */}
            <div className="ai-model-options">
              {aiModels
                .filter((model) => model.difficulty === difficulty)
                .map((model) => (
                  <button
                    key={model.id}
                    className="btn btn-primary start-btn"
                    onClick={() => startGameWithAIModel(model)}
                  >
                    Bắt đầu chơi
                  </button>
                ))}
            </div>
          </div>
        </div>
      )}

      {/* HIển thị bàn cờ, điểm, thông tin và các nút  */}
      {(gameState === GameState.PLAYING || gameState === GameState.FINISHED) && (
        <div className="game-board-container">
          <div className="game-info">
            <div className="player-info">
              <div className="player-disc black"></div>
              <span>Bạn: {scores.black}</span>
            </div>
            <div className="player-info">
              <div className="player-disc white"></div>
              <span>AI: {scores.white}</span>
            </div>
            {gameState === GameState.PLAYING && (
              <>
              {/* Xử lý các trạng thái đợi người chơi đánh, AI đánh và khi ko có nước đi hợp lệ */}
                <div className="turn-indicator">
                  {isProcessing
                    ? "Đợi AI đánh..."
                    : currentPlayer === Disc.BLACK
                    ? hasValidMove
                      ? "Lượt của bạn"
                      : "Không có nước đi hợp lệ. Hãy chuyển lượt."
                    : "Đợi AI đánh..."}
                </div>
                {/* Chỉ có thể ấn nếu ko còn nước đi hợp lệ */}
                <button
                  className="btn btn-secondary pass-btn"
                  onClick={handlePass}
                  disabled={currentPlayer !== Disc.BLACK || hasValidMove || isProcessing}
                >
                  Pass
                </button>
                {/* Chỉ có thể ấn tại lượt người chơi chống lỗi */}
                <button
                  className="btn btn-secondary surrender-btn"
                  onClick={handleSurrender}
                  disabled={currentPlayer !== Disc.BLACK || isProcessing}
                >
                  Bỏ cuộc
                </button>
              </>
            )}
          </div>

          <div className="game-board">
            {board.map((row, rowIndex) => (
              <div key={rowIndex} className="board-row">
                {row.map((cell, colIndex) => {
                  const isValidMove = validMoves.some(([r, c]) => r === rowIndex && c === colIndex);

                  // Hiển thị gợi ý các ô hợp lệ và hiển thị quân cờ
                  return (
                    <div
                      key={colIndex}
                      className={`board-cell ${isValidMove && gameState === GameState.PLAYING && !isProcessing ? "valid-move" : ""}`}
                      onClick={() => handleCellClick(rowIndex, colIndex)}
                    >
                      {cell !== Disc.EMPTY && <div className={`disc ${cell === Disc.BLACK ? "black" : "white"}`}></div>}
                      {isValidMove && gameState === GameState.PLAYING && currentPlayer === Disc.BLACK && !isProcessing && (
                        <div className="move-hint"></div>
                      )}
                    </div>
                  );
                })}
              </div>
            ))}
          </div>

            {/* HIển thị thêm các nút chơi lại, quay về trang chủ va đổi độ khó cùng điểm */}
          {gameState === GameState.FINISHED && (
            <div className="game-result">
              <h3>{gameResult}</h3>
              <p>
                Tổng điểm: Bạn {scores.black} - {scores.white} AI
              </p>
              <div className="result-buttons">
                <button className="btn btn-primary" onClick={handlePlayAgain}>
                  Chơi lại
                </button>
                <button className="btn btn-secondary" onClick={() => setGameState(GameState.SETUP)}>
                  Đổi độ khó
                </button>
                <button className="btn btn-secondary" onClick={() => navigate("/")}>
                  Về trang chủ
                </button>
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  )
}

export default Game