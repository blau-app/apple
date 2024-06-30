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

    @State var accountFilterType: AccountTypeFilter = .all
    @State var accounts: [Account] = .init()

    var body: some View {
        NavigationView {
            AccountsContent()
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
                .toolbar(content: {})
                .navigationTitle("Accounts")
        }
        .task {
            do {
                try await capsuleManager.fetchWallets().forEach { wallet in
                    accounts.append(Account(id: wallet.id, wallet: wallet))
                }
                for publicAccount in settings.publicAccounts {
                    accounts.append(Account(id: publicAccount.address, publicAccount: publicAccount))
                }
                loading = false
            } catch {
                print("SESSION ACTIVE: \(error)")
            }
        }
    }

    @ViewBuilder
    private func AccountsContent() -> some View {
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
                Section {
                    ForEach($accounts) { $account in
                        AccountItem(account: account)
                    }.onDelete(perform: delete)
                } header: {
                    FilterItem(filter: $accountFilterType)
                        .padding(.horizontal, SECTION_HEADER_PADDING)
                        .padding(.bottom, 12)
                        .padding(.top, -12)
                }
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

    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            switch accounts[offset].type {
            case let .publicAccount(publicAccount):
                print("remove public account")
            // remove public acocunt
            case let .wallet(wallet):
                // remove wallet
                print("remove wallet")
            }
        }
        accounts.remove(atOffsets: offsets)
    }
}

#Preview {
    AccountsView()
        .environmentObject(CapsuleManager(environment: .beta(jsBridgeUrl: nil),
                                          apiKey: ""))
}
