//
//  LoginView.swift
//  FirebaseAuthApp
//
//  Created by Meghan Murphy on 7/27/25.
//

import SwiftUI

struct PinkTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(Color(.systemPink).opacity(0.1)) // light pink background
            .foregroundColor(.hotPink) // hot pink text
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.hotPink.opacity(0.7), lineWidth: 1)
            )
    }
}

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showSignup = false

    var body: some View {
        VStack {
            Text("Login to the best app ever")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.hotPink)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            TextField("Email", text: $email)
                .textFieldStyle(PinkTextFieldStyle())

            SecureField("Password", text: $password)
                .textFieldStyle(PinkTextFieldStyle())
            
                Button("Login") {
                    auth.login(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
                .tint(.hotPink)
                
                Button("Signup") {
                    showSignup = true
                }
                .buttonStyle(.bordered)
                .tint(.hotPink)
            }
        
        .padding()
        .fullScreenCover(isPresented: $showSignup) {
            SignupView()
        }
    }
}
