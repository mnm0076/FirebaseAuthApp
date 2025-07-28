//
//  FirebaseAuthAppApp.swift
//  FirebaseAuthApp
//
//  Created by Meghan Murphy on 7/27/25.
//

import SwiftUI
import FirebaseCore

@main
struct FirebaseAuthAppApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authViewModel)
                .task {
                    do {
                        try await FirebaseApp.configure()
                        // Now tell the view model Firebase is ready
                        await authViewModel.checkLoginStatus()
                    } catch {
                        print("Firebase failed to configure: \(error)")
                    }
                }
        }
    }
}
