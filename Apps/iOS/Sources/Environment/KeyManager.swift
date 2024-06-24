// KeyManager.swift
// Copyright (c) 2024 Party Labs, Inc

import CapsuleSwift
import SwiftUI

@Observable class KeyManager {
    @MainActor
    var capsule = Capsule(environment: .beta(jsBridgeUrl: nil),
                          apiKey: CAPSULE_API_KEY)
}

struct KeyManagerKey: EnvironmentKey {
    static let defaultValue: KeyManager = .init()
}

extension EnvironmentValues {
    var keyManager: KeyManager {
        get { self[KeyManagerKey.self] }
        set { self[KeyManagerKey.self] = newValue }
    }
}
