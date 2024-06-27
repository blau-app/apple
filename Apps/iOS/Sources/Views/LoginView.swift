// LoginView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.auth) private var auth

    var body: some View {
        let biometryType = auth.context.biometryType
        ContentUnavailableView {
            Label(biometryType.labelText, systemImage: biometryType.systemImage)
                .symbolRenderingMode(.hierarchical)
        } description: {
            Text(biometryType.description)
        } actions: {
            Button {
                login()
            } label: {
                Label(biometryType.labelText, systemImage: biometryType.systemImage)
                    .fontWeight(.bold)
            }.disabled(!biometryType.isSupported)
                .buttonStyle(.borderedProminent)
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
