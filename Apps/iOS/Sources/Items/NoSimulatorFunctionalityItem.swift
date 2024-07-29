// NoSimulatorFunctionalityItem.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct NoSimulatorFunctionalityItem: View {
    var body: some View {
        ContentUnavailableView {
            Label("Simulator", systemImage: "desktopcomputer.and.macbook")
                .symbolRenderingMode(.hierarchical)
        } description: {
            Text("You need to use a real device to access this functionality")
        }
    }
}

#Preview {
    NoSimulatorFunctionalityItem()
}
