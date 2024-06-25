// TokensView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct TokensView: View {
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.keyManager) private var keyManager
    @Environment(\.settings) private var settings

    let avatarBeam = AvatarBeam()

    var body: some View {
        @Bindable var settings = settings
        NavigationStack {
            ContentUnavailableView("No Tokens",
                                   systemImage: "circle.slash",
                                   description: Text("No tokens yet..."))
                .navigationTitle("Tokens")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu(content: {
                            Button {
                                accounts()
                            } label: {
                                Label("Accounts", systemImage: "person.text.rectangle")
                            }
                            Divider()
                            Button(role: .destructive) {
                                logout()
                            } label: {
                                Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                            }
                        }, label: {
                            avatarBeam.createAvatarView(name: "Need Key", size: 32)
                        })
                    }
                }
        }
        .fullScreenCover(item: $settings.presented, onDismiss: {
            Task {
                do {
                    let wallets = try await keyManager.capsule.fetchWallets()
                    print(wallets)
                } catch {
                    print("LOAD WALLETS \(error)")
                }
            }
        }, content: { presented in
            switch presented {
            case .accounts: AccountsView()
            case .onboarding: OnboardingView()
            }
        })
    }

    private func accounts() {
        settings.presented = .accounts
    }

    private func logout() {
        Task {
            do {
                try await keyManager.capsule.logout()
            } catch {
                print("LOGOUT: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    TokensView()
}
