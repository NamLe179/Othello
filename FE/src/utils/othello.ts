// Màu quân
export enum Disc {
  EMPTY = 0,
  BLACK = 1,
  WHITE = 2,
}

// Hướng
export const DIRECTIONS = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1],
]

// Khởi tạo bàn cờ
export const initializeBoard = (): Disc[][] => {
  const board: Disc[][] = Array(8)
    .fill(null)
    .map(() => Array(8).fill(Disc.EMPTY))

  board[3][3] = Disc.WHITE
  board[3][4] = Disc.BLACK
  board[4][3] = Disc.BLACK
  board[4][4] = Disc.WHITE

  return board
}

// Kiểm tra hợp lệ
export const isValidMove = (board: Disc[][], row: number, col: number, player: Disc): boolean => {
  if (board[row][col] !== Disc.EMPTY) {
    return false
  }

  const opponent = player === Disc.BLACK ? Disc.WHITE : Disc.BLACK
  let isValid = false

  // Kiểm tra mọi hướng
  for (const [dx, dy] of DIRECTIONS) {
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

// TÌm tất cả nước đi hợp lệ
export const findValidMoves = (board: Disc[][], player: Disc): [number, number][] => {
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

// Đi và lật cờ
export const makeMove = (board: Disc[][], row: number, col: number, player: Disc): Disc[][] => {
  const newBoard = board.map((row) => [...row])
  newBoard[row][col] = player

  const opponent = player === Disc.BLACK ? Disc.WHITE : Disc.BLACK

  for (const [dx, dy] of DIRECTIONS) {
    let r = row + dx
    let c = col + dy
    const discsToFlip: [number, number][] = []

    // Đưa vào list cờ sẽ lật
    while (r >= 0 && r < 8 && c >= 0 && c < 8 && newBoard[r][c] === opponent) {
      discsToFlip.push([r, c])
      r += dx
      c += dy
    }

    // Lật
    if (r >= 0 && r < 8 && c >= 0 && c < 8 && newBoard[r][c] === player && discsToFlip.length > 0) {
      for (const [flipRow, flipCol] of discsToFlip) {
        newBoard[flipRow][flipCol] = player
      }
    }
  }

  return newBoard
}

// Tính điểm
export const calculateScores = (board: Disc[][]): { black: number; white: number } => {
  let black = 0
  let white = 0

  for (let row = 0; row < 8; row++) {
    for (let col = 0; col < 8; col++) {
      if (board[row][col] === Disc.BLACK) {
        black++
      } else if (board[row][col] === Disc.WHITE) {
        white++
      }
    }
  }

  return { black, white }
}
