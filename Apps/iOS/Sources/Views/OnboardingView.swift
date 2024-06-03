// OnboardingView.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

struct OnboardingView: View {
    @Binding var presentOnboard: Bool
    var body: some View {
        Text("Welcome To Blau")
        Button(action: {
            presentOnboard = false
        }, label: {
            Text("Onboard")
        }).buttonStyle(.borderedProminent)
    }
}

#Preview {
    OnboardingView(presentOnboard: .constant(true))
}
