// TokensView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct TokensView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings

    private let avatarBeam = AvatarBeam()
    @State private var tokenTypeFilter: TokenTypeFilter = .allTokens

    var body: some View {
        @Bindable var settings = settings
        NavigationStack {
            Tokens()
                .navigationTitle("Tokens")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu(content: {
                            Button {
                                accounts()
                            } label: {
                                Label("Accounts", systemImage: "person.text.rectangle")
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
                } catch {
                    print("LOAD WALLETS \(error)")
                }
            }
        }, content: { presented in
            switch presented {
            case .accounts: AccountsView()
            case .addAccount: AddWatchAccountView()
            }
        })
    }

    @ViewBuilder
    private func Empty() -> some View {
        ContentUnavailableView {
            Label("Load Account", image: "piggy-bank")
        } description: {
            Text("We are going to get you started with some free tokens. You can also send tokens to your account.")
        } actions: {
            Button { settings.presented = .addAccount } label: {
                Label("Watch Account", systemImage: "eye")
                    .fontWeight(.bold)
            }.controlSize(.large)
            Button {} label: {
                Label("Deposit Tokens", systemImage: "qrcode")
                    .fontWeight(.bold)
            }.buttonStyle(.bordered)
                .controlSize(.large)
            Button {} label: {
                Label("Claim Free Tokens", image: "hand-coins")
                    .fontWeight(.bold)
            }.buttonStyle(.borderedProminent)
                .controlSize(.large)
        }
    }

    @ViewBuilder func Tokens() -> some View {
        List {
            Section {} header: {
                FilterItem(filter: $tokenTypeFilter)
                    .padding(.horizontal, SECTION_HEADER_PADDING)
            }
        }
    }

    private func accounts() {
        settings.presented = .accounts
    }
}

#Preview {
    TokensView()
        .environmentObject(CapsuleManager(environment: .beta(jsBridgeUrl: nil),
                                          apiKey: ""))
}
