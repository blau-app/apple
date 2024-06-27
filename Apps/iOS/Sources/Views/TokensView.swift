// TokensView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct TokensView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings

    let avatarBeam = AvatarBeam()

    var body: some View {
        @Bindable var settings = settings
        NavigationStack {
            ContentUnavailableView {
                Label("Claim Free Tokens", systemImage: "bitcoinsign.circle")
            } description: {
                Text("We are going to get you started with some free tokens. You can also send tokens to your wallet address")
            } actions: {
                Button {} label: {
                    Label("Receive Tokens", systemImage: "qrcode")
                        .fontWeight(.bold)
                }.buttonStyle(.bordered)
                    .controlSize(.large)
                Button {} label: {
                    Label("Claim Free Tokens", systemImage: "square.and.arrow.down")
                        .fontWeight(.bold)
                }.buttonStyle(.borderedProminent)
                    .controlSize(.large)
            }
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
                        switch capsuleManager.wallet?.publicKey {
                        case let .some(publicKey): avatarBeam.createAvatarView(name: publicKey,
                                                                               size: 32)
                        case .none: Image(systemName: "exclamationmark.triangle")
                        }
                    })
                }
            }
        }
        .fullScreenCover(item: $settings.presented, onDismiss: {
            Task {
                do {
                    let wallets = try await capsuleManager.fetchWallets()
                    print(wallets)
                } catch {
                    print("LOAD WALLETS \(error)")
                }
            }
        }, content: { presented in
            switch presented {
            case .accounts: AccountsView()
            }
        })
    }

    private func accounts() {
        settings.presented = .accounts
    }

    private func logout() {
        Task {
            do {
                try await capsuleManager.logout()
            } catch {
                print("LOGOUT: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    TokensView()
        .environmentObject(CapsuleManager(environment: .beta(jsBridgeUrl: nil),
                                          apiKey: ""))
}
