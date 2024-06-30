// Account.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import Foundation

struct Account: Identifiable {
    let id: String
    let type: AccountType

    var filter: AccountTypeFilter {
        switch type {
        case .wallet: return .private
        case .watch: return .watch
        }
    }

    var name: String {
        switch type {
        case let .wallet(wallet):
            return wallet.name ?? "Unnamed Wallet"
        case let .watch(watch):
            return watch.name
        }
    }

    var address: String? {
        switch type {
        case let .wallet(wallet):
            return wallet.address
        case let .watch(watch):
            return watch.address
        }
    }

    init(id: String, wallet: Wallet) {
        self.id = id
        type = .wallet(wallet)
    }

    init(id: String, watch: Watch) {
        self.id = id
        type = .watch(watch)
    }

    func getWallet() -> Wallet? {
        if case let .wallet(wallet) = type {
            return wallet
        }
        return nil
    }

    func getWatch() -> Watch? {
        if case let .watch(watch) = type {
            return watch
        }
        return nil
    }
}
