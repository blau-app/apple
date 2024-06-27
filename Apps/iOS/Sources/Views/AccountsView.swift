// AccountsView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct AccountsView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings
    @Environment(\.dismiss) private var dismiss

    @State var loading: Bool = true
    @State var wallets: [Wallet] = .init()

    var body: some View {
        NavigationView {
            Group {
                switch loading {
                case true:

                    ContentUnavailableView {
                        ProgressView().controlSize(.extraLarge).padding(.bottom, -8)
                        Label("Loading", systemImage: "")
                    } description: {
                        Text("Loading")
                    }
                case false:
                    List {
                        ForEach(wallets, id: \.address) { wallet in
                            LabeledContent {
                                Text(wallet.name ?? "")
                                Text(wallet.keyGenComplete?.description ?? "-")
                            } label: {
                                Text(wallet.address ?? "addy")
                                Text(wallet.publicKey ?? "pubk")
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark")
                    }
                }
            }
            .navigationTitle("Accounts")
        }
        .task {
            do {
                wallets = try await capsuleManager.fetchWallets()
                loading = false
            } catch {
                print("SESSION ACTIVE: \(error)")
            }
        }
    }
}

#Preview {
    AccountsView()
        .environmentObject(CapsuleManager(environment: .beta(jsBridgeUrl: nil),
                                          apiKey: ""))
}
