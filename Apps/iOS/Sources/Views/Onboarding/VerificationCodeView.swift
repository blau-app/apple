// VerificationCodeView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct VerificationCodeView: View {
    @EnvironmentObject private var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings

    @FocusState private var isCodeFocused: Bool
    @State private var isCodeProcessing: Bool = false
    @State private var code: String = ""

    var body: some View {
        ZStack {
            HeroItem()
                .ignoresSafeArea()
            VStack {
                Text("Verify Code")
                    .h1()
                    .shadow(color: .black, radius: 4)

                TextField(text: $code) {
                    Text("Verification Code")
                }
                .primaryMaterial()
                .focused($isCodeFocused)
                .multilineTextAlignment(.center)
                .focused($isCodeFocused)
                .textContentType(.oneTimeCode)
                .keyboardType(.numberPad)
                .disabled(isCodeProcessing)

                Button {
                    verify(code: code)
                } label: {
                    HStack {
                        switch isCodeProcessing {
                        case true:
                            ProgressView()
                                .controlSize(.regular)
                                .tint(.white)
                            Text("Verify Code")
                        case false:
                            Text("Verify Code")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .primary()
            }
            .colorScheme(.dark)
            .padding()
        }
        .task {
            isCodeFocused = true
        }
    }

    private func verify(code: String) {
        Task {
            do {
                isCodeProcessing = true
                guard let email = settings.email else {
                    fatalError("no email")
                }
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
    VerificationCodeView()
}
