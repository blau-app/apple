// AccountsView.swift
// Copyright (c) 2024 Superdapp, Inc

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

    var filteredAccounts: [Account] {
        switch accountFilterType {
        case .all: accounts
        case .private, .watch: accounts.filter { $0.filter == accountFilterType }
        }
    }

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
                        Menu(content: {
                            Button { settings.presented = .addAccount } label: {
                                Label("Watch Account", systemImage: "eye")
                            }
                            Divider()
                            Button(role: .destructive) {
                                showLogoutAlert = true
//                                logout()
                            } label: {
                                Text("Logout")
                            }
                        }, label: {
                            Image(systemName: "ellipsis")
                        })
                    }
                }
                .toolbar(content: {})
                .navigationTitle("Accounts")
        }
        .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Logout", role: .destructive) {
                logout()
            }
        }
        .task {
            do {
                try await capsuleManager.fetchWallets().forEach { wallet in
                    accounts.append(Account(id: wallet.id, wallet: wallet))
                }
                for watch in settings.watch {
                    accounts.append(Account(id: watch.address, watch: watch))
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
                    ForEach(filteredAccounts) { account in
                        AccountItem(account: account)
                            .deleteDisabled(isWallet(account.type))
                    }.onDelete(perform: delete)
                } header: {
                    FilterItem(filter: $accountFilterType)
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

    private func isWallet(_ account: AccountType) -> Bool {
        if case .wallet = account {
            return true
        }
        return false
    }

    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            switch accounts[offset].type {
            case let .watch(watch):
                if let index = settings.watch.firstIndex(where: { $0.address == watch.address }) {
                    settings.watch.remove(at: index)
                }
            case .wallet:
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
