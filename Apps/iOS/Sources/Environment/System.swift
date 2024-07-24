// System.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

@Observable class System: NSObject {
    var presentedAction: Action? = nil
}

struct SystemKey: EnvironmentKey {
    static let defaultValue: System = .init()
}

extension EnvironmentValues {
    var system: System {
        get { self[SystemKey.self] }
        set { self[SystemKey.self] = newValue }
    }
}
