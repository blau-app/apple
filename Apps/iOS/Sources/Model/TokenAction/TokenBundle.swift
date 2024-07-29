// TokenBundle.swift
// Copyright (c) 2024 Superdapp, Inc

import Foundation

struct TokenBundle: Identifiable {
    var id: String {
        let combinedIDs = (tokensIn.map { $0.id } + (tokensOut?.map { $0.id } ?? [])).joined(separator: "-")
        return combinedIDs.sha256
    }

    var tokensIn: [Token]
    var tokensOut: [Token]? = nil
    var actions: [Action] = .init()
    var balance: Balance {
        var totalBalanceValue = 0.0
        var totalBalanceFiat = 0.0
        for token in tokensIn {
            totalBalanceValue += token.balance.value
            totalBalanceFiat += token.balance.fiat
        }
        if let tokensOut = tokensOut {
            for token in tokensOut {
                totalBalanceValue += token.balance.value
                totalBalanceFiat += token.balance.fiat
            }
        }
        return Balance(value: totalBalanceValue, fiat: totalBalanceFiat)
    }
}
