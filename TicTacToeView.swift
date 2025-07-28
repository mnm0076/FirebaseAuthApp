//
//  TicTacToeView.swift
//  FirebaseAuthApp
//
//  Created by Meghan Murphy on 7/27/25.
//

import SwiftUI

extension Color {
    static let hotPink = Color(red: 1.0, green: 0.2, blue: 0.6)
}

struct TicTacToeView: View {
    @State private var board: [String] = Array(repeating: "", count: 9)
    @State private var isUserTurn = true
    @State private var gameOverMessage = ""

    @State private var userWins = 0
    @State private var appWins = 0
    @State private var draws = 0

    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .foregroundColor(.hotPink)
                .fontWeight(.bold)
            
            

                Text("You: \(userWins)   App: \(appWins)   Draws: \(draws)")
                    .font(.subheadline)
                    .padding(.bottom)
                    .foregroundColor(.hotPink)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                ForEach(0..<9) { i in
                    ZStack {
                        Rectangle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.hotPink.opacity(0.15))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.hotPink, lineWidth: 2)
                            )

                        Text(board[i])
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(board[i] == "X" ? .black : .hotPink)
                    }
                    .onTapGesture {
                        handleTap(at: i)
                    }
                }
            }

            if !gameOverMessage.isEmpty {
                Text(gameOverMessage)
                    .foregroundColor(.hotPink)
                    .padding()
                Button("Play Again") {
                    resetBoard()
                }
            }
        }
        .padding()
    }

    func handleTap(at index: Int) {
        guard isUserTurn, board[index] == "", gameOverMessage.isEmpty else { return }
        board[index] = "O"
        isUserTurn = false

        if checkWin("O") {
            userWins += 1
            gameOverMessage = "You beat the bot!"
            return
        } else if board.allSatisfy({ $0 != "" }) {
            draws += 1
            gameOverMessage = "It's a draw!"
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            appMove()
        }
    }

    func appMove() {
        // 1. Try to win
        if let winIndex = findBestMove(for: "X") {
            board[winIndex] = "X"
            finishMove()
            return
        }

        // 2. Try to block O
        if let blockIndex = findBestMove(for: "O") {
            board[blockIndex] = "X"
            finishMove()
            return
        }

        // 3. Take center
        if board[4] == "" {
            board[4] = "X"
            finishMove()
            return
        }

        // 4. Take a corner
        let corners = [0, 2, 6, 8].filter { board[$0] == "" }
        if let corner = corners.randomElement() {
            board[corner] = "X"
            finishMove()
            return
        }

        // 5. Pick a random spot
        let emptyIndices = board.indices.filter { board[$0] == "" }
        if let randomIndex = emptyIndices.randomElement() {
            board[randomIndex] = "X"
            finishMove()
        }
    }
    
    func findBestMove(for symbol: String) -> Int? {
        for pattern in [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
            [0, 4, 8], [2, 4, 6]             // diagonals
        ] {
            let values = pattern.map { board[$0] }
            if values.filter({ $0 == symbol }).count == 2,
               let emptyIndex = pattern.first(where: { board[$0] == "" }) {
                return emptyIndex
            }
        }
        return nil
    }
    
    func finishMove() {
        if checkWin("X") {
            appWins += 1
            gameOverMessage = "I win! Better luck next time!"
        } else if board.allSatisfy({ $0 != "" }) {
            draws += 1
            gameOverMessage = "It's a draw!"
        } else {
            isUserTurn = true
        }
    }

    func checkWin(_ symbol: String) -> Bool {
        let winPatterns = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
            [0, 4, 8], [2, 4, 6]             // diagonals
        ]

        return winPatterns.contains { pattern in
            pattern.allSatisfy { board[$0] == symbol }
        }
    }

    func resetBoard() {
        board = Array(repeating: "", count: 9)
        isUserTurn = true
        gameOverMessage = ""
    }
}
