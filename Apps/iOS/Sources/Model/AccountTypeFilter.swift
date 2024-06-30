// AccountTypeFilter.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

enum AccountTypeFilter: Filterable {
    var id: Self { self }
    case all
    case `private`
    case `public`

    var label: Label<Text, Image> {
        switch self {
        case .all: Label("All", systemImage: "key")
        case .private: Label("Private", systemImage: "lock")
        case .public: Label("Public", systemImage: "lock.open")
        }
    }

    var color: Color {
        switch self {
        case .all: .blue
        case .private: .pink
        case .public: .green
        }
    }
}
