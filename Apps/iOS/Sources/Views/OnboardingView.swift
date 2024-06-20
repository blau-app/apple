// OnboardingView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct OnboardingView: View {
    enum FocusField: Hashable {
        case email, code
    }

    @Environment(\.authorizationController) private var authorizationController

    @FocusState private var focusedField: FocusField?

    @State var email: String = ""
    @State var isEmailProcessing: Bool = false
    @State var showVerify: Bool = false
    @State var code: String = ""
    @State var isCodeProcessing: Bool = false

    @StateObject var capsule = Capsule(environment: .beta(jsBridgeUrl: nil),
                                       apiKey: CAPSULE_API_KEY)

    @Binding var presentOnboard: Bool
    var body: some View {
        NavigationStack {
            ZStack {
                CapsuleWebView(capsule: capsule).hidden()
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
                                login(email: email)
                            } label: {
                                HStack(spacing: 2) {
                                    if isEmailProcessing {
                                        ProgressView()
                                    }
                                    Text("Login")
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
        }
        .onAppear {
            focusedField = .email
        }
    }

    private func login(email: String) {
        Task {
            do {
                isEmailProcessing = true
                let userExists = try await capsule.checkIfUserExists(email: email)
                if userExists {
                    return
                }
                try await capsule.createUser(email: email)
                showVerify = true
                focusedField = .code
                isEmailProcessing = false
            } catch {
                isEmailProcessing = false
                print("LOGIN: \(error)")
            }
        }
    }

    private func verify(code: String) {
        Task {
            do {
                isCodeProcessing = true
                let biometricsId = try await capsule.verify(verificationCode: code)

                try await capsule.generatePasskey(email: email,
                                                  biometricsId: biometricsId,
                                                  authorizationController: authorizationController)
                try await capsule.createWallet(skipDistributable: false)
                isCodeProcessing = false
            } catch {
                print("VERIFY: \(error)")
            }
        }
    }
}

#Preview {
    OnboardingView(presentOnboard: .constant(true))
}
