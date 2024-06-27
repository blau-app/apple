// BlauApp.swift
// Copyright (c) 2024 Party Labs, Inc

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
        WindowGroup {
            ZStack {
                CapsuleWebView(capsuleManager: capsuleManager).hidden()
                VStack {
                    switch capsuleManager.sessionState {
                    case .unknown:
                        LoadingView()
                    case .inactive:
                        OnboardingView()
                    case .active:
                        LoginView()
                    case .activeLoggedIn:
                        TokensView()
                    }
                }
            }
            .environmentObject(capsuleManager)
        }
    }
}
