// SignInView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.auth) private var auth

    var body: some View {
        ZStack {
            GeometryReader { _ in
                HeroItem()
                    .overlay(
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0.44),
                                .init(color: Color(uiColor: .systemBackground), location: 0.66),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                if let appIcon = UIImage.appIcon {
                    Image(uiImage: appIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 96)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(.tertiary, lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                }
                TitleSubtitle()
                Actions()
            }
        }
    }

    @ViewBuilder
    private func TitleSubtitle() -> some View {
        VStack(spacing: 10) {
            Text("Welcome to Superdapp")
                .h1()
            Text("Access to crypto in one easy to use expereince")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.system(.headline, design: .rounded))
        }
        .padding()
    }

    @ViewBuilder
    private func Actions() -> some View {
        let biometryType = auth.context.biometryType

        VStack(spacing: 10) {
            Button {
                login()
            } label: {
                Label(biometryType.labelText, systemImage: biometryType.systemImage)
                    .frame(maxWidth: .infinity)
            }
            .primary()

            Text("Your privacy is our prioirty. You are the only person who has access to your private keys.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.system(.caption, design: .rounded))
        }
        .padding()
    }

    // MARK: - Actions

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
    SignInView()
}
