// TokensView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct TokensView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings
    @Environment(\.api) private var api

    private let avatarBeam = AvatarBeam()
    @State private var tokenTypeFilter: TokenTypeFilter = .allTokens
    @State private var tokenBundles: [TokenBundle] = .init()

    var body: some View {
        @Bindable var settings = settings
        NavigationStack {
            TokensContent()
                .navigationTitle("Tokens")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu(content: {
                            Button {} label: {
                                Label("Deposit Tokens", systemImage: "qrcode")
                            }
                            Divider()
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
                    tokenBundles = api.getTokenBundles(addresses: wallets.compactMap { $0.address })
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
    private func TokensContent() -> some View {
        switch tokenBundles.count {
        case 0: EmptyContent()
        default: TokenBundlesContent()
        }
    }

    @ViewBuilder
    private func EmptyContent() -> some View {
        ContentUnavailableView {
            Label("Claim Free Tokens", image: "hand-coins")
        } description: {
            Text("We are going to get you started with some free tokens and get you earnings in under 60 seconds.")
        } actions: {
            Button {} label: {
                Label("Claim Free Tokens", image: "hand-coins")
                    .fontWeight(.bold)
            }.buttonStyle(.borderedProminent)
                .controlSize(.large)
        }
    }

    @ViewBuilder
    private func TokenBundlesContent() -> some View {
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
