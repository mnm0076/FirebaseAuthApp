//
//  LoginView.swift
//  FirebaseAuthApp
//
//  Created by Meghan Murphy on 7/27/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showSignup = false

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            if let error = auth.errorMessage {
                Text(error).foregroundColor(.red)
            }

            Button("Login") {
                auth.login(email: email, password: password)
            }

            Button("Go to Signup") {
                showSignup = true
            }
        }
        .padding()
        .fullScreenCover(isPresented: $showSignup) {
            SignupView()
        }
    }
}
