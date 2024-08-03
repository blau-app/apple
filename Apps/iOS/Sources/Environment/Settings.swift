// Settings.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

@Observable class Settings {
    var presentedFullScreen: PresentedFullScreen?
    var presentedSheet: PresentedSheet?
    var onboardingState: OnboardingState = .loading

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

    var onboardComplete: Bool = UserDefaults.standard.bool(forKey: "com.superdapp.onboard.complete") {
        didSet {
            UserDefaults.standard.setValue(onboardComplete, forKey: "com.superdapp.onboard.complete")
        }
    }

    var email: String? = UserDefaults.standard.string(forKey: "capsule.email.address") {
        didSet {
            UserDefaults.standard.setValue(email, forKey: "capsule.email.address")
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
