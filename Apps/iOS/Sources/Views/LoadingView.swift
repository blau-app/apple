// LoadingView.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ContentUnavailableView {
            ProgressView().controlSize(.extraLarge).padding(.bottom, -8)
            Label("Loading", systemImage: "")
        } description: {
            Text("Initializing keychain for secure self-custody transactions")
        }
    }
}

#Preview {
    LoadingView()
}
