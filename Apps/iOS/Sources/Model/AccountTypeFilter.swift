// AccountTypeFilter.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

enum AccountTypeFilter: Filterable {
    var id: Self { self }
    case allKeys
    case privateKeys
    case publicKeys

    var label: Label<Text, Image> {
        switch self {
        case .allKeys: Label("All", systemImage: "key")
        case .privateKeys: Label("Private", systemImage: "lock")
        case .publicKeys: Label("Public", systemImage: "lock.open")
        }
    }

    var color: Color {
        switch self {
        case .allKeys: .blue
        case .privateKeys: .pink
        case .publicKeys: .green
        }
    }
}
