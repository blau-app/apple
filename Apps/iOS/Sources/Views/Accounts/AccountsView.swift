// AccountsView.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

struct AccountsView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.settings) private var settings
    @Environment(\.dismiss) private var dismiss

    @State private var showLogoutAlert = false
    @State private var loading: Bool = true
    @State private var wallets: [Wallet] = .init()
    
    var body: some View {
        NavigationView {
            Group {
                switch loading {
                case true:
                    ContentUnavailableView {
                        ProgressView().controlSize(.extraLarge)
                        Text("Loading").fontWeight(.bold)
                    } description: {
                        Text("Loading")
                    }
                case false:
                    List {
                        ForEach(wallets, id: \.address) { wallet in
                            WalletItem(wallet: wallet)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showLogoutAlert = true
                    } label: {
                        Text("Logout")
                    }
                    .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Logout", role: .destructive) {
                            logout()
                        }
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
    AccountsView()
        .environmentObject(CapsuleManager(environment: .beta(jsBridgeUrl: nil),
                                          apiKey: ""))
}
