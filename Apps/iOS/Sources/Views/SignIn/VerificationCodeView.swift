// VerificationCodeView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct VerificationCodeView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings

    @State var code: String = ""
    @State var isCodeProcessing: Bool = false
    @Binding var email: String
    @FocusState private var focusedField: SignInFocusField?

    var body: some View {
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
    VerificationCodeView(email: .constant("test@email.com"))
}
