//
//  MainView.swift
//  Isolation
//
//  Created by Rohan Modi on 3/30/23.
//

import SwiftUI

struct MainView: View {
    @State var buttonColors = [Color.blue, Color.blue, Color.blue, Color.blue, Color.blue, Color.blue]
    @State var startGame = false;
    @State var size = 3;
    var difficultyLevel = [1, 2, 3, 4, 5]
    @State private var difficulty = 1


    var body: some View {
        
        
        NavigationView {
            NavigationLink(destination: ContentView(size: size, difficulty: difficulty, board: Board(boardSize: size, difficulty: difficulty))) {
                VStack {
                    Spacer()
                    Text("Isolation")
                        .font(.system(size: 40))
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(2, contentMode: .fit)
                        .foregroundColor(Color.white)
                        .padding()
                    VStack {
                        Picker("Please choose a level", selection: $difficulty) {
                            ForEach(difficultyLevel, id: \.self) {
                                Text("Level " + String($0))
                            }
                        }
                        .onTapGesture {
                            print(difficulty)
                        }
                    }
                    .padding()
                    HStack {
                        Text("5x5")
                            .font(.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(2, contentMode: .fit)
                            .foregroundColor(Color.white)
                            .background(buttonColors[0])
                            .onTapGesture {
                                print(difficulty)
                                size = 5
                                startGame = true
                                if buttonColors[0] == Color.blue {
                                    setAllButtonColors(color: Color.blue)
                                    buttonColors[0] = Color.green
                                } else {
                                    buttonColors[0] = Color.blue
                                }
                            }
                        Text("6x6")
                            .font(.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(2, contentMode: .fit)
                            .foregroundColor(Color.white)
                            .background(buttonColors[1])
                            .onTapGesture {
                                size = 6
                                startGame = true
                                if buttonColors[1] == Color.blue {
                                    setAllButtonColors(color: Color.blue)
                                    buttonColors[1] = Color.green
                                } else {
                                    buttonColors[1] = Color.blue
                                }
                            }
                    }
                    HStack {
                        Text("7x7")
                            .font(.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(2, contentMode: .fit)
                            .foregroundColor(Color.white)
                            .background(buttonColors[2])
                            .onTapGesture {
                                size = 7
                                startGame = true
                                if buttonColors[2] == Color.blue {
                                    setAllButtonColors(color: Color.blue)
                                    buttonColors[2] = Color.green
                                } else {
                                    buttonColors[2] = Color.blue
                                }
                            }
                        Text("8x8")
                            .font(.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(2, contentMode: .fit)
                            .foregroundColor(Color.white)
                            .background(buttonColors[3])
                            .onTapGesture {
                                size = 8
                                startGame = true
                                if buttonColors[3] == Color.blue {
                                    setAllButtonColors(color: Color.blue)
                                    buttonColors[3] = Color.green
                                } else {
                                    buttonColors[3] = Color.blue
                                }
                            }
                    }
                    HStack {
                        Text("9x9")
                            .font(.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(2, contentMode: .fit)
                            .foregroundColor(Color.white)
                            .background(buttonColors[4])
                            .onTapGesture {
                                size = 9
                                startGame = true
                                if buttonColors[4] == Color.blue {
                                    setAllButtonColors(color: Color.blue)
                                    buttonColors[4] = Color.green
                                } else {
                                    buttonColors[4] = Color.blue
                                }
                            }
                        Text("10x10")
                            .font(.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(2, contentMode: .fit)
                            .foregroundColor(Color.white)
                            .background(buttonColors[5])
                            .onTapGesture {
                                size = 10
                                startGame = true
                                if buttonColors[5] == Color.blue {
                                    setAllButtonColors(color: Color.blue)
                                    buttonColors[5] = Color.green
                                    
                                } else {
                                    buttonColors[5] = Color.blue
                                }
                            }
                    }
                    Text("Start")
                        .font(.system(size: 30))
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(4, contentMode: .fit)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                }
                .padding()
            }
        }
    }
    func setAllButtonColors(color: Color) {
        buttonColors[0] = color
        buttonColors[1] = color
        buttonColors[2] = color
        buttonColors[3] = color
        buttonColors[4] = color
        buttonColors[5] = color
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
