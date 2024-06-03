// TokensView.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

struct TokensView: View {
    @State var presentOnboard = true
    var body: some View {
        NavigationStack {
            ContentUnavailableView("No Tokens",
                                   systemImage: "circle.slash",
                                   description: Text("No tokens yet..."))
                .navigationTitle("Tokens")
        }
        .fullScreenCover(isPresented: $presentOnboard, content: {
            OnboardingView(presentOnboard: $presentOnboard)
        })
    }
}

#Preview {
    TokensView()
}
