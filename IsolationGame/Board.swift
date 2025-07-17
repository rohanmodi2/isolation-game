import Foundation
import SwiftUI

class Board: ObservableObject {
    @Published var content = [[Cell]]()
    @Published var player1 = Player(name: "U")
    @Published var player2 = Player(name: "A")
    @Published var turn = "U"
    @Published var allowedMovesList = [[Int]]()
    @Published var shouldComputerPlay = true
    @Published var size: Int
    @Published var difficulty = 1
    
    /**
     * Initializes empty board with self.size = boardSize
     * and self.difficulty = difficulty.
     */
    init(boardSize: Int, difficulty: Int) {
        size = boardSize
        createEmptyBoard(difficulty: difficulty)
    }
    
    /**
     * Creates empty board with self.difficulty = difficulty
     * and sets all global variables to their default values:
     * sets turn = player 1,
     * sets content to new array with every cell empty.
     */
    func createEmptyBoard(difficulty: Int) {
        turn = "U"
        content = [[Cell]]()
        player1 = Player(name: "U")
        player2 = Player(name: "A")
        
        for _ in 0...(size-1) {
            var row = [Cell]()
            for _ in 0...(size-1) {
                row.append(Cell(newPlayer: ""))
            }
            content.append(row)
        }
        allowedMovesList = allowedMoves(playerTurn: player1)
    }

    
    /**
     * Checks if it is player 2's turn and if the program
     * is set for the computer player to play. If shouldComputerPlay is false,
     * let the user decide moves for player 2. Otherwise, use ComputerPlayer.CustomPlayer
     * to decide a move for player 2.
     */
    func checkComputerPlayerTurn() {
        if turn == "A" && shouldComputerPlay {
            let computerPlayer = CustomPlayer(computerPlayer: player2)
            let move = computerPlayer.move(board: self)
            if move[0] >= 0 && move[1] >= 0 {
                setCell(row: move[0], col: move[1])
            }
        }
    }
    
    /**
     * Takes row and column of board cell as parameters and returns true
     * if cell is in allowedMovesList. Otherwise, returns false.
     */
    func updateCells(row: Int, col: Int) -> Bool {
        var allowedMove = false
        for i in 0 ... allowedMovesList.count-1 {
            let newCell = content[allowedMovesList[i][0]][allowedMovesList[i][1]]
            if !newCell.visited { newCell.setCell(newPlayer: "") }
            if row == allowedMovesList[i][0] && col == allowedMovesList[i][1] { allowedMove = true }
        }
        return allowedMove
    }
    
    /**
     * Takes row and column of board cell as parameters and sets that cell to
     * current player and sets cell.visited to true if move is allowed.
     */
    func setCell(row: Int, col: Int) {
        if content[row][col].visited { return }
        
        var player = turn == "U" ? player1 : player2
        var allowedMove = false
        if !allowedMovesList.isEmpty {
            allowedMove = updateCells(row: row, col: col)
        }
        if player.numberMoves > 0 && !allowedMove { return }
        
        // Update board immediately
        content[row][col] = Cell(newPlayer: turn)
        content[row][col].visited = true
        
        if player.numberMoves > 0 {
            content[player.lastPosition[0]][player.lastPosition[1]].isActive = false
        }
        
        // Existing logic to fill cells based on move...
        fillCellsBetween(player: player, row: row, col: col)
        
        content[row][col].isActive = true
        player.lastPosition = [row, col]
        player.numberMoves += 1
        
        turn = turn == "U" ? "A" : "U"
        player = turn == "U" ? player1 : player2
        allowedMovesList = allowedMoves(playerTurn: player)
        
        // Delay the AI's move slightly to allow SwiftUI to update the player's move first
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.checkComputerPlayerTurn()
        }
    }

    func fillCellsBetween(player: Player, row: Int, col: Int) {
        if player.numberMoves == 0 { return }
        
        let lastRow = player.lastPosition[0]
        let lastCol = player.lastPosition[1]
        
        var dRow = (row - lastRow).signum()
        var dCol = (col - lastCol).signum()
        
        var i = lastRow
        var j = lastCol
        
        while i != row || j != col {
            content[i][j] = Cell(newPlayer: turn)
            content[i][j].visited = true
            i += dRow
            j += dCol
        }
        // Ensure final cell is set
        content[row][col] = Cell(newPlayer: turn)
        content[row][col].visited = true
    }

    
    /**
     * Checks if either player 1 or player 2 has no moves left. If either
     * player has won, returns true. Otherwise, returns false.
     */
    func checkVictory() -> Bool {
        var player = player1
        if turn == "A" { player = player2 }
        if player.numberMoves == 0 { return false }
        let row = player.lastPosition[0]
        let col = player.lastPosition[1]
        if row > 0 && !content[row-1][col].visited {return false}
        if row < (size-1) && !content[row+1][col].visited {return false}
        if col > 0 && !content[row][col-1].visited {return false}
        if col < (size-1) && !content[row][col+1].visited {return false}
        if row > 0 && col > 0 && !content[row-1][col-1].visited {return false}
        if row > 0 && col < (size-1) && !content[row-1][col+1].visited {return false}
        if row < (size-1) && col > 0 && !content[row+1][col-1].visited {return false}
        if row < (size-1) && col < (size-1) && !content[row+1][col+1].visited {return false}
        self.checkComputerPlayerTurn()
        return true
    }
    
    /**
     * Returns an array of all possible moves for player = playerTurn.
     */
    func allowedMoves(playerTurn: Player) -> [[Int]] {
        var moves = [[Int]]()
        var player: Player
        player = player1
        if playerTurn.disp == "A" { player = player2 }
        if player.numberMoves == 0 {
            for i in 0...(size-1) {
                for j in 0...(size-1) {
                    if !content[i][j].visited { moves.append([i, j]) }
                }
            }
            return moves
        }
        let row = player.lastPosition[0]
        let col = player.lastPosition[1]
        if row < 0 || row > (size-1) || col < 0 || col > (size-1) { return [] }
        if row <= (size-2) {
            for i in row+1 ... (size-1) {
                if !content[i][col].visited { moves.append([i, col]) ; content[i][col].setCell(newPlayer: " ")}
                else { break }
            }
        }
        for i in stride(from: row-1, to: -1, by: -1) {
            if !content[i][col].visited { moves.append([i, col]) ; content[i][col].setCell(newPlayer: " ") }
            else { break }
        }
        if col <= (size-2) {
            for i in col+1 ... (size-1) {
                if !content[row][i].visited { moves.append([row, i]) ; content[row][i].setCell(newPlayer: " ") }
                else { break }
            }
        }
        for i in stride(from: col-1, to: -1, by: -1) {
            if !content[row][i].visited { moves.append([row, i]) ; content[row][i].setCell(newPlayer: " ") }
            else { break }
        }
        
        var i = row + 1
        var j = col + 1
        while i <= (size-1) && j <= (size-1) {
            if !content[i][j].visited { moves.append([i, j]) ; content[i][j].setCell(newPlayer: " ") }
            else { break }
            i += 1
            j += 1
        }
        i = row - 1
        j = col + 1
        while i >= 0 && j <= (size-1) {
            if !content[i][j].visited { moves.append([i, j]) ; content[i][j].setCell(newPlayer: " ") }
            else { break }
            i -= 1
            j += 1
        }
        i = row - 1
        j = col - 1
        while i >= 0 && j >= 0 {
            if !content[i][j].visited { moves.append([i, j]) ; content[i][j].setCell(newPlayer: " ") }
            else { break }
            i -= 1
            j -= 1
        }
        i = row + 1
        j = col - 1
        while i <= (size-1) && j >= 0 {
            if !content[i][j].visited { moves.append([i, j]) ; content[i][j].setCell(newPlayer: " ") }
            else { break }
            i += 1
            j -= 1
        }
        return moves
    }
    
    /**
     * Creates a new board with all attributes same as current board,
     * sets move = [row, column] and returns new board.
     */
    func forecastMove(move: [Int]) -> Board{
        let newBoard = Board(boardSize: size, difficulty: self.difficulty)
        newBoard.shouldComputerPlay = false
        newBoard.player1 = Player(name: player1.disp)
        newBoard.player1.lastPosition = player1.lastPosition
        newBoard.player1.numberMoves = player1.numberMoves
        newBoard.player1.curPos = player1.curPos
        newBoard.player2 = Player(name: player2.disp)
        newBoard.player2.lastPosition = player2.lastPosition
        newBoard.player2.numberMoves = player2.numberMoves
        newBoard.player2.curPos = player2.curPos
        newBoard.turn = turn
        newBoard.allowedMovesList = allowedMovesList
        newBoard.setCell(row: move[0], col: move[1])
        newBoard.difficulty = self.difficulty
        newBoard.content = [[Cell]]()
        for row in 0...(size-1) {
            var newRow = [Cell]()
            for col in 0...(size-1) {
                let oldCell = self.content[row][col]
                let newCell = Cell(newPlayer: oldCell.currentPlayer.disp)
                newCell.visited = self.content[row][col].visited
                newCell.isActive = self.content[row][col].isActive
                newRow.append(newCell)
            }
            newBoard.content.append(newRow)
        }
        return newBoard
    }
}

