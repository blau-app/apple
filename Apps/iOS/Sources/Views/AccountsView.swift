// AccountsView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct AccountsView: View {
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.keyManager) private var keyManager
    @Environment(\.settings) private var settings
    @Environment(\.dismiss) private var dismiss

    @State var wallets: [Wallet] = .init()

    var body: some View {
        NavigationView {
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
                wallets = try await keyManager.capsule.fetchWallets()
            } catch {
                print("SESSION ACTIVE: \(error)")
            }
        }
    }
}

#Preview {
    AccountsView()
}
