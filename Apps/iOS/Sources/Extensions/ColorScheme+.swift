// ColorScheme+.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

extension ColorScheme {
    var blendMode: BlendMode {
        switch self {
        case .dark: return .plusLighter
        case .light: return .plusDarker
        default: return .normal
        }
    }

    var ringColor: Color {
        switch self {
        case .dark: Color(UIColor.secondarySystemBackground)
        default: Color(UIColor.systemBackground)
        }
    }
}
