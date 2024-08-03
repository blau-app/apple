// EmailView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct EmailView: View {
    @EnvironmentObject private var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings

    @FocusState private var isEmailFocused: Bool
    @State private var isEmailProcessing: Bool = false

    @State var email: String = ""

    var body: some View {
        ZStack {
            HeroItem()
                .ignoresSafeArea()
            VStack {
                Text("Sign Up")
                    .h1()
                    .shadow(color: .black, radius: 4)

                TextField(text: $email) {
                    Text("Email Address")
                }
                .primaryMaterial()
                .focused($isEmailFocused)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .autocapitalization(.none)

                Button {
                    signUp(email: email.trimmingCharacters(in: .whitespacesAndNewlines))
                } label: {
                    HStack {
                        switch isEmailProcessing {
                        case true:
                            ProgressView()
                                .controlSize(.regular)
                                .tint(.white)
                            Text("Signing Up")
                        case false:
                            Text("Sign Up")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .primary()
                .disabled(isEmailProcessing)
            }
            .colorScheme(.dark)
            .padding()
        }
        .task {
            isEmailFocused = true
        }
    }

    // MARK: - Actions

    private func signUp(email: String) {
        Task {
            do {
                isEmailProcessing = true
                guard try await !capsuleManager.checkIfUserExists(email: email) else {
                    try await capsuleManager.login(authorizationController: authorizationController)
                    return
                }
                try await capsuleManager.createUser(email: email)
                settings.email = email
                isEmailProcessing = false
                settings.onboardingState = .signUpVerification
            } catch {
                isEmailProcessing = false
                print("SIGNUP: \(error)")
            }
        }
    }
}

#Preview {
    EmailView()
}
