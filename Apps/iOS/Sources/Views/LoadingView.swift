// LoadingView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ContentUnavailableView {
            ProgressView().controlSize(.extraLarge)
            Text("Loading").fontWeight(.bold)
        } description: {
            Text("Initializing keychain for secure self-custody transactions")
        }
    }
}

#Preview {
    LoadingView()
}
