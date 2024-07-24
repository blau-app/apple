// TokensView.swift
// Copyright (c) 2024 Superdapp, Inc

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
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Menu(content: {
//                            Button {} label: {
//                                Label("Deposit Tokens", systemImage: "qrcode")
//                            }
//                            Divider()
//                            Button {
//                                settings.presented = .accounts
//                            } label: {
//                                Label("Accounts", systemImage: "person.text.rectangle")
//                            }
//                        }, label: {
//                            switch capsuleManager.wallet?.publicKey {
//                            case let .some(publicKey): avatarBeam.createAvatarView(name: publicKey,
//                                                                                   size: 32)
//                            case .none: Image(systemName: "exclamationmark.triangle")
//                            }
//                        })
//                    }
                }
        }
        .task {
            await loadTokensView()
        }
        .fullScreenCover(item: $settings.presented, onDismiss: {
            Task {
                await loadTokensView()
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
            Label("Get Started", image: "hand-coins")
        } description: {
            Text("We are going to get you started in under a minute.")
        } actions: {
            Button {} label: {
                Label("Buy with Stripe", systemImage: "dollarsign")
                    .fontWeight(.bold)
            }.buttonStyle(.borderedProminent)
                .controlSize(.large)
            Button {} label: {
                Label("Receive", systemImage: "qrcode")
                    .fontWeight(.bold)
            }.buttonStyle(.bordered)
                .controlSize(.large)
        }
    }

    @ViewBuilder
    private func TokenBundlesContent() -> some View {
        List {
            Section {
                ForEach($tokenBundles) { $tokenBundle in
                    TokenBundleItem(tokenBundle: $tokenBundle)
                }
            } header: {
                FilterItem(filter: $tokenTypeFilter)
            }
        }
    }

    private func loadTokensView() async {
        do {
            let wallets = try await capsuleManager.fetchWallets()
            tokenBundles = try await api.getTokenBundles(addresses: wallets.compactMap { $0.address })
        } catch {
            print("LOAD WALLETS \(error)")
        }
    }
}

#Preview {
    TokensView()
        .environmentObject(CapsuleManager(environment: .beta(jsBridgeUrl: nil),
                                          apiKey: ""))
}
