// Presented.swift
// Copyright (c) 2024 Superdapp, Inc

import Foundation

enum Presented: Identifiable {
    case onramp
    case accounts
    case addAccount
    case tokenAction(Action)

    var id: String {
        switch self {
        case .onramp: "onramp"
        case .accounts: "accounts"
        case .addAccount: "addAccount"
        case let .tokenAction(action): "tokenAction_\(action.id)"
        }
    }
}
