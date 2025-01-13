# Isolation: A Two-Player AI Game for iOS

**Isolation** is a strategy game where two players aim to isolate the other player's pawn on a grid. In this iOS app, players can play against each other or challenge an AI opponent that uses the minimax algorithm with alpha-beta pruning and iterative deepening. The game offers multiple difficulty levels for the AI.


https://github.com/user-attachments/assets/935e9aa2-7d7b-4ef0-8e00-2e05a973cda1


## Features

- **AI Player**: The AI opponent uses advanced algorithms (minimax with alpha-beta pruning and iterative deepening) to make decisions.
- **Human vs Human**: Play against another player on the same device.
- **AI Difficulty Levels**: Multiple difficulty settings for the AI player.
- **Responsive UI**: The game adapts to different screen sizes and resolutions using SwiftUI.
- **Game State**: The game keeps track of moves, and automatically switches turns between Player 1 and Player 2.


## Code Structure

### Player.swift
Defines the `Player` class, which represents a player in the game (either human or AI). The player’s state is tracked, including their last position and the number of moves they’ve made.

### ComputerPlayer.swift
Contains the logic for the AI opponent, which uses the **minimax algorithm** with **alpha-beta pruning** to decide the best possible move.

### Cell.swift
Defines the `Cell` class, representing each square on the game board. It manages the current player occupying the cell and determines how it is displayed.

### Board.swift
The `Board` class contains the entire game state, including player turns, allowed moves, and logic for checking victory conditions. It also contains methods to forecast potential moves and update the board accordingly.

### ContentView.swift
The main UI for the game, built using **SwiftUI**. It displays the board and allows the user to interact with it. It also provides buttons for resetting the game and checking victory conditions.
