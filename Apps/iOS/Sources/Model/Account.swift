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
        case .publicAccount: return .public
        }
    }

    var name: String {
        switch type {
        case let .wallet(wallet):
            return wallet.name ?? "Unnamed Wallet"
        case let .publicAccount(publicAccount):
            return publicAccount.name
        }
    }

    var address: String? {
        switch type {
        case let .wallet(wallet):
            return wallet.address
        case let .publicAccount(publicAccount):
            return publicAccount.address
        }
    }

    init(id: String, wallet: Wallet) {
        self.id = id
        type = .wallet(wallet)
    }

    init(id: String, publicAccount: PublicAccount) {
        self.id = id
        type = .publicAccount(publicAccount)
    }

    func getWallet() -> Wallet? {
        if case let .wallet(wallet) = type {
            return wallet
        }
        return nil
    }

    func getPublicAccount() -> PublicAccount? {
        if case let .publicAccount(publicAccount) = type {
            return publicAccount
        }
        return nil
    }
}
