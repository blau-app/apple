// SignUpView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct SignUpView: View {
    enum FocusField: Hashable {
        case email, code
    }

    @EnvironmentObject var capsuleManager: CapsuleManager

    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings

    @FocusState private var focusedField: FocusField?

    @State var email: String = ""
    @State var showVerify: Bool = false
    @State var code: String = ""
    @State var isEmailProcessing: Bool = false
    @State var isCodeProcessing: Bool = false
    @State var isLoginProcessing: Bool = false

    var body: some View {
        @Bindable var settings = settings

        NavigationStack {
            Form {
                Section {
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

                if showVerify {
                    Section {
                        TextField(text: $code) {
                            Text("Verification Code")
                        }
                        .focused($focusedField, equals: .code)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.numberPad)
                        .disabled(isCodeProcessing)
                        Button {
                            verify(code: code)
                        } label: {
                            HStack(spacing: 2) {
                                if isCodeProcessing {
                                    ProgressView()
                                }
                                Text("Verify")
                            }
                        }.disabled(isCodeProcessing)
                    }
                }
            }
        }
        .navigationTitle("Sign Up")
        .onAppear {
            focusedField = .email
        }
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

    private func verify(code: String) {
        Task {
            do {
                isCodeProcessing = true
                let biometricsId = try await capsuleManager.verify(verificationCode: code)
                print("generating passkey")
                try await capsuleManager.generatePasskey(email: email,
                                                         biometricsId: biometricsId,
                                                         authorizationController: authorizationController)
                print("creating wallet")
                try await capsuleManager.createWallet(skipDistributable: false)

                print("wallet created")
                isCodeProcessing = false
            } catch {
                isCodeProcessing = false
                print("VERIFY: \(error)")
            }
        }
    }
}

#Preview {
    SignUpView()
}
