// AccountTypeFilter.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

enum AccountTypeFilter: Filterable {
    var id: Self { self }
    case all
    case `private`
    case watch

    var label: Label<Text, Image> {
        switch self {
        case .all: Label("All", systemImage: "key")
        case .private: Label("Private", systemImage: "lock")
        case .watch: Label("Watch", systemImage: "eye")
        }
    }

    var color: Color {
        switch self {
        case .all: .blue
        case .private: .pink
        case .watch: .green
        }
    }
}
