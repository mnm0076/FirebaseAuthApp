//
//  SignupView.swift
//  FirebaseAuthApp
//
//  Created by Meghan Murphy on 7/27/25.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            Text("Signup")
                .font(.largeTitle)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            if let error = auth.errorMessage {
                Text(error).foregroundColor(.hotPink)
            }

            Button("Create Account") {
                auth.signup(email: email, password: password)
            }

            Button("Back to Login") {
                dismiss()
            }
        }
        .padding()
    }
}
