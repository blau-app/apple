// BlauApp.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

@main
struct BlauApp: App {
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.settings) private var settings
    @StateObject private var capsuleManager = CapsuleManager(environment: .beta(jsBridgeUrl: nil),
                                                             apiKey: CAPSULE_API_KEY)

    var body: some Scene {
        @Bindable var settings = settings
        WindowGroup {
            ZStack {
                CapsuleWebView(capsuleManager: capsuleManager).hidden()
                VStack {
                    switch settings.onboardingState {
                    case .loading: LoadingView()
                    case .signIn: SignInView()
                    case .signUpEmail: EmailView()
                    case .signUpVerification: VerificationCodeView()
                    case .loggedIn: TokensView()
                    }
                }
            }
            .onChange(of: capsuleManager.sessionState) { handleSessionStateChange() }
            .environmentObject(capsuleManager)
        }
        .onChange(of: scenePhase) { _, newValue in
            Task {
                switch newValue {
                case .active: try await updateOnboardingState()
                case .inactive, .background: break
                @unknown default: break
                }
            }
        }
    }

    // MARK: - Session

    private func handleSessionStateChange() {
        Task {
            try await updateOnboardingState()
        }
    }

    private func updateOnboardingState() async throws {
        guard capsuleManager.isCapsuleInitialized else { return }
        guard let email = settings.email,
              try await capsuleManager.checkIfUserExists(email: email)
        else {
            settings.onboardingState = .signUpEmail
            return
        }

        guard try await capsuleManager.isSessionActive() else {
            settings.onboardingState = .signIn
            return
        }

        capsuleManager.wallet = try await capsuleManager.fetchWallets().first
        settings.onboardingState = .loggedIn
    }
}
