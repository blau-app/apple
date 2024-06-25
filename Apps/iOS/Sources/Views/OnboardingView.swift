// OnboardingView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct OnboardingView: View {
    enum FocusField: Hashable {
        case email, code
    }

    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.keyManager) private var keyManager
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
//            ZStack {
//                CapsuleWebView(capsule: keyManager.capsule).hidden()
            VStack {
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

                        Button {
                            signUp(email: email)
                        } label: {
                            HStack(spacing: 2) {
                                if isEmailProcessing {
                                    ProgressView()
                                }
                                Text("Sign Up")
                            }
                        }.disabled(showVerify || isEmailProcessing)

                        Button {
                            login()
                        } label: {
                            HStack(spacing: 2) {
                                if isLoginProcessing {
                                    ProgressView()
                                }
                                Text("Login")
                            }
                        }
                    }

                    if showVerify {
                        Section {
                            TextField(text: $code) {
                                Text("Verification Code")
                            }
                            .focused($focusedField, equals: .code)
                            .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
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
        }
        .navigationTitle("Login")
        .onAppear {
            focusedField = .email
        }
    }

    private func signUp(email: String) {
        Task {
            do {
                isEmailProcessing = true
                let userExists = try await keyManager.capsule.checkIfUserExists(email: email)
                if userExists {
                    isEmailProcessing = false
                    settings.presented = nil
                    return
                }
                try await keyManager.capsule.createUser(email: email)
                showVerify = true
                focusedField = .code
                isEmailProcessing = false
            } catch {
                isEmailProcessing = false
                print("SIGNUP: \(error)")
            }
        }
    }

    private func login() {
        Task {
            do {
                isLoginProcessing = true
                try await keyManager.capsule.login(authorizationController: authorizationController)
                isLoginProcessing = false
                settings.presented = nil
            } catch {
                print("LOGIN: \(error)")
            }
        }
    }

    private func verify(code: String) {
        Task {
            do {
                isCodeProcessing = true
                let biometricsId = try await keyManager.capsule.verify(verificationCode: code)
                print("generating passkey")
                try await keyManager.capsule.generatePasskey(email: email,
                                                             biometricsId: biometricsId,
                                                             authorizationController: authorizationController)
                print("creating wallet")
                try await keyManager.capsule.createWallet(skipDistributable: false)

                print("setting email")
                settings.emailAddress = email
                isCodeProcessing = false
                settings.presented = nil
            } catch {
                print("VERIFY: \(error)")
            }
        }
    }
}

#Preview {
    OnboardingView()
}
