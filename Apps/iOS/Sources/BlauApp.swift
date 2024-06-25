// BlauApp.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

@main
struct BlauApp: App {
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.keyManager) private var keyManager
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.settings) private var settings

    var body: some Scene {
        WindowGroup {
            ZStack {
                CapsuleWebView(capsule: keyManager.capsule).hidden()
                TokensView()
            }
        }
        .onChange(of: scenePhase) { _, _ in
            switch scenePhase {
            case .active:
                print("auto login")
                // TODO: Check if a user has an account then auto login
                Task {
                    do {
                        try await keyManager.capsule.login(authorizationController: authorizationController)
                    } catch {
                        print("SCENE LOGIN: \(error)")
                    }
                }
            case .background, .inactive: break
            @unknown default: break
            }
        }
    }
}
