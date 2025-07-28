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
                    .padding()
                    .foregroundColor(.hotPink)
                    .font(.largeTitle)
                    
                    
                    NavigationLink("Play Tic-Tac-Toe") {
                        TicTacToeView()
                    }
                    .foregroundColor(.hotPink)
                    
                    Button("Logout :(") {
                        auth.logout()
                    }
                    .foregroundColor(.black)
                }
                .padding()
            }
        }
    }

