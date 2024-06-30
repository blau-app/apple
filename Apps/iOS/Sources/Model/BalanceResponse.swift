// BalanceResponse.swift
// Copyright (c) 2024 Party Labs, Inc

import Foundation

struct BalanceResponse: Codable {
    let chainId: Int
    let address: String?
    let name: String
    let symbol: String
    let decimals: Int
    let logoURI: String
    let publicKey: String
    let balance: String
}

extension BalanceResponse {
    var toToken: Token {
        Token(address: address,
              chainId: chainId,
              name: name,
              symbol: symbol,
              decimals: decimals)
    }
}
