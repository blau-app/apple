// SignInFlowView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct SignInFlowView: View {
    @FocusState private var focusedField: SignInFocusField?

    @State private var signInFlow: SignInSteps = .email

    @State var email: String = ""

    var body: some View {
        switch signInFlow {
        case .signin: SignInView()
        case .email: EmailView(email: $email)
        case .verification: VerificationCodeView(email: $email)
        case .welcome: WelcomeView()
        }
    }
}

#Preview {
    SignInFlowView()
}
