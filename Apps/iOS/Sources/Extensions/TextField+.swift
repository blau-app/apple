// TextField+.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

extension TextField {
    func primaryMaterial() -> some View {
        foregroundColor(.primary)
            .padding()
            .background(.ultraThinMaterial)
            .frame(maxWidth: 360)
            .clipShape(Capsule())
    }
}
