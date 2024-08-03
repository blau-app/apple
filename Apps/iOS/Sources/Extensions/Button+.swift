// Button+.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

extension Button {
    @ViewBuilder
    func setButtonStyle(isSelected: Bool) -> some View {
        switch isSelected {
        case true: buttonStyle(BorderedProminentButtonStyle())
        case false: buttonStyle(BorderedButtonStyle())
        }
    }

    func primary() -> some View {
        font(.headline)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: 360)
            .tint(.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
