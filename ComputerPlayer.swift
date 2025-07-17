import Foundation

/**
 * Returns difference between number of player's allowed moves
 * and number of otherPlayer's allowed moves.
 */
func score(board: Board, player: Player) -> Int {
    var otherPlayer = board.player1
    if player.disp == "U" { otherPlayer = board.player2 }
    return board.allowedMoves(playerTurn: player).count - board.allowedMoves(playerTurn: otherPlayer).count
}

class CustomPlayer {
    var player: Player
    
    /**
     * Initializes computerPlayer with player = computerPlayer argument.
     */
    init(computerPlayer: Player) { player = computerPlayer }
    
    /**
     * Returns best move returned by alphabeta() based on given board, such that
     * computerPlayer is player "A" and user is player "U".
     */
    func move(board: Board) -> [Int] {
        let date = Date()
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let moveAndScore = alphabeta(time: [minute, seconds], player: player, board: board, depth: 50, alpha1: Float(-9999999999999), beta1: Float(9999999999999), myTurn: true, newMove1: [-1, -1])
        return moveAndScore.move
    }
}

/**
 * Returns newMove and minValue after performing alphabeta pruning recursively.
 * Return value is a CombineMoveAndScore object with move = newMove and
 * score = minValue.
 */
func alphabeta(time: [Int], player: Player, board: Board, depth: Int, alpha1: Float, beta1: Float, myTurn: Bool, newMove1: [Int]) -> CombineMoveAndScore {
    var alpha = alpha1
    var newMove = newMove1
    var beta = beta1
    let date = Date()
    let calendar = Calendar.current
    // let cur_minute = calendar.component(.minute, from: date)
    let cur_seconds = calendar.component(.second, from: date)
    if depth == 0 || cur_seconds-time[1] > board.difficulty || time[1]-cur_seconds > board.difficulty {
        return CombineMoveAndScore(moveInput: newMove, scoreInput: score(board: board, player: player))
    }
    if myTurn {
        var maxValue = Float(-9999999999999)
        for move in board.allowedMoves(playerTurn: player) {
            let newBoard = board.forecastMove(move: move)
            let _ = newBoard.checkVictory()
            let nextMoveAndScore = alphabeta(time: time, player: board.player2, board: newBoard, depth: depth-1, alpha1: alpha, beta1: beta, myTurn: false, newMove1: move)
            let _ = nextMoveAndScore.move
            let nextScore = nextMoveAndScore.score
            if Float(nextScore) > maxValue {
                maxValue = Float(nextScore)
                newMove = move
            }
            alpha = Float(max(Float(nextScore), alpha))
            if alpha >= beta { break }
        }
        return CombineMoveAndScore(moveInput: newMove, scoreInput: Int(maxValue))
    } else {
        var minValue = Float(9999999999999)
        for move in board.allowedMoves(playerTurn: player) {
            let newBoard = board.forecastMove(move: move)
            var _ = newBoard.checkVictory()
            let nextMoveAndScore = alphabeta(time: time, player: board.player1, board: newBoard, depth: depth-1, alpha1: alpha, beta1: beta, myTurn: true, newMove1: move)
            let _ = nextMoveAndScore.move
            let nextScore = nextMoveAndScore.score
            if Float(nextScore) < minValue {
                minValue = Float(nextScore)
                newMove = move
            }
            beta = Float(min(Float(nextScore), beta))
            if beta <= alpha { break }
        }
        return CombineMoveAndScore(moveInput: newMove, scoreInput: Int(minValue))
    }
}

class CombineMoveAndScore {
    var move: [Int]
    var score: Int
    init(moveInput: [Int], scoreInput: Int) {
        move = moveInput
        score = scoreInput
    }
}
