import Foundation
import SwiftUI


class Cell {
    @Published var currentPlayer = Player(name: "0")
    @Published var visited = false
    @Published var isActive = false
    @Published var color = Color.white
    
    /**
     * Initializes empty cell with self.newPlayer = newPlayer,
     * visited = false, isActive = false, and color = white.
     */
    init(newPlayer: String) {
        setCell(newPlayer: newPlayer)
    }
    
    /**
     * Sets cell's newPlayer = newPlayer.
     */
    func setCell(newPlayer: String) {
        currentPlayer = Player(name: newPlayer)
    }
    
    /**
     * Returns player's name as a String if isActive is true. Otherwise,
     * returns an empty string.
     */
    func displayCell() -> String {
        if isActive { return currentPlayer.disp }
        return ""
    }
    
    /**
     * Returns white if cell is empty, red if currentPlayer is 1 and isActive is true,
     * blue if currentPlayer is 2 and isActive is true, black if currentPlayer is either
     * 1 or 2 but isActive is false, and green otherwise.
     */
    func displayColor(row: Int, col: Int) -> Color {
        if currentPlayer.disp == "" { return Color.white }
        if isActive {
            if currentPlayer.disp == "U" { return Color.red }
            if currentPlayer.disp == "A" { return Color.blue }
        } else {
            if currentPlayer.disp == "U" || currentPlayer.disp == "A" { return Color.black }
        }
        return Color.green
    }
}

