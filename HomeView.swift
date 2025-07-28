//
//  HomeView.swift
//  FirebaseAuthApp
//
//  Created by Meghan Murphy on 7/27/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome!")
                    .font(.title)

                NavigationLink("Play Tic-Tac-Toe") {
                    TicTacToeView()
                }

                Button("Logout") {
                    auth.logout()
                }
            }
            .padding()
        }
    }
}
