// TokenTypeFilter.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

enum TokenTypeFilter: Filterable {
    var id: Self { self }
    case allTokens
    case fungibleTokens
    case nonFungibleTokens
    case deFiTokens

    var label: Label<Text, Image> {
        switch self {
        case .allTokens: Label("All", image: "piggy-bank")
        case .fungibleTokens: Label("Coins", image: "coins")
        case .nonFungibleTokens: Label("Collectibles", systemImage: "wallet.pass")
        case .deFiTokens: Label("Bank", image: "landmark")
        }
    }

    var color: Color {
        switch self {
        case .allTokens: .blue
        case .fungibleTokens: .pink
        case .nonFungibleTokens: .green
        case .deFiTokens: .orange
        }
    }
}
