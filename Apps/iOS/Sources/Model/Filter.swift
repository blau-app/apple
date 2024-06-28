// Filter.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

enum Filter: Filterable {
    var id: Self { self }
    case allKeys
    case privateKeys
    case publicKeys

    var title: String {
        switch self {
        case .allKeys: "All"
        case .privateKeys: "Private"
        case .publicKeys: "Public"
        }
    }

    var systemImage: String {
        switch self {
        case .allKeys: "key"
        case .privateKeys: "lock"
        case .publicKeys: "lock.open"
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
