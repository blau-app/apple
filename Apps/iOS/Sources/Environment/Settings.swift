// Settings.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

@Observable class Settings {
    var presented: Presented?
}

struct SettingsKey: EnvironmentKey {
    static let defaultValue: Settings = .init()
}

extension EnvironmentValues {
    var settings: Settings {
        get { self[SettingsKey.self] }
        set { self[SettingsKey.self] = newValue }
    }
}
