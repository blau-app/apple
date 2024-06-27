// LoginView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController

    var body: some View {
        ContentUnavailableView {
            Label("Login", systemImage: "faceid")
        } description: {
            Text("Login with biometrics to unlock your wallet and manage your tokens.")
        } actions: {
            Button {
                login()
            } label: {
                Text("Login")
                    .fontWeight(.bold)
            }.buttonStyle(.borderedProminent)
                .controlSize(.large)
        }
    }

    func login() {
        Task {
            do {
                try await capsuleManager.login(authorizationController: authorizationController)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    LoginView()
}
