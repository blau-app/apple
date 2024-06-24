// TokensView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct TokensView: View {
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.keyManager) private var keyManager
    @Environment(\.settings) private var settings

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
                            AsyncImageItem(imageURI: "https://avatar.blau.app/beam?name=boomba", width: 32, height: 32)
                        })
                    }
                }
        }
        .fullScreenCover(isPresented: $settings.presentOnboard, onDismiss: {
            Task {
                do {
                    let wallets = try await keyManager.capsule.fetchWallets()
                    print(wallets)
                } catch {
                    print("LOAD WALLETS \(error)")
                }
            }
        }, content: {
            OnboardingView(presentOnboard: $settings.presentOnboard)
        })
    }

    private func accounts() {
        Task {
            do {
                let isActive = try await keyManager.capsule.isSessionActive()

                print(isActive)
            } catch {
                print("Session Active \(error)")
            }
        }
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
