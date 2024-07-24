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
//                    switch capsuleManager.sessionState {
//                    case .unknown:
//                        LoadingView()
//                    case .noUser:
//                        SignUpView()
//                    case .inactive:
//                        LoginView()
//                    case .active:
                    TokensView()
//                    }
                }
            }
            .environmentObject(capsuleManager)
        }
        .onChange(of: scenePhase) { _, newValue in
            Task {
                switch newValue {
                case .active: try await capsuleManager.updateSessionState()
                case .inactive, .background: return
                @unknown default: return
                }
            }
        }
    }
}
