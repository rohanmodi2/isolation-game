//
//  ContentView.swift
//  Isolation
//
//  Created by Rohan Modi on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    @State var size: Int
    @State var difficulty: Int
    @StateObject var board: Board
    var body: some View {
        VStack {
            Button("Reset Board") {
                board.createEmptyBoard(difficulty: difficulty)
            } .padding()
            VStack {
                ForEach(0...(size-1), id: \.self) { row in
                    HStack {
                        ForEach(0...(size-1), id: \.self) { col in
                            Text(board
                                .content[row][col]
                                .displayCell())
                            .font(.system(size: 25))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(board.content[row][col].displayColor(row: row, col: col))
                            .onTapGesture {
                                board
                                    .setCell(row: row, col: col)
                            }
                        }
                    }
                }
            }
            .background(Color.black)
            .padding()
            VStack {
                Button(board.checkVictory() ? (board.turn == "1" ? "Player 2 Wins!" : "Player 1 Wins!") : "Turn: " + (board.turn == "1" ? "Player 1" : "Player 2")) {
                        board.checkComputerPlayerTurn();
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(size: 9, difficulty: 1, board: Board(boardSize: 9, difficulty: 1))
    }
}
