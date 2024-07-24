// Settings.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

@Observable class Settings {
    var presented: Presented?

    var watch: [Watch] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "com.superdapp.public.accounts") else {
                return []
            }
            return (try? JSONDecoder().decode([Watch].self, from: data)) ?? []
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "com.superdapp.public.accounts")
            }
        }
    }
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
