// EmailView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct EmailView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager

    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings

    @FocusState private var focusedField: SignInFocusField?

    @Binding var email: String

    @State var showVerify: Bool = false
    @State var isEmailProcessing: Bool = false
    @State var isLoginProcessing: Bool = false

    var body: some View {
        @Bindable var settings = settings
        TextField(text: $email) {
            Text("Email Address")
        }

        .focused($focusedField, equals: .email)
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
        .autocorrectionDisabled()
        .autocapitalization(.none)
        .disabled(showVerify || isEmailProcessing)

        Button {
            signUp(email: email.trimmingCharacters(in: .whitespacesAndNewlines))
        } label: {
            HStack(spacing: 2) {
                if isEmailProcessing {
                    ProgressView()
                }
                Text("Sign Up")
            }
        }.disabled(showVerify || isEmailProcessing)
    }

    private func signUp(email: String) {
        Task {
            do {
                isEmailProcessing = true
                guard try await !capsuleManager.checkIfUserExists(email: email) else {
                    try await capsuleManager.login(authorizationController: authorizationController)
                    return
                }
                try await capsuleManager.createUser(email: email)
                showVerify = true
                focusedField = .code
                isEmailProcessing = false
            } catch {
                isEmailProcessing = false
                print("SIGNUP: \(error)")
            }
        }
    }
}

#Preview {
    EmailView(email: .constant("test@email.com"))
}
