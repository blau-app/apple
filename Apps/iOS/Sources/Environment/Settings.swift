//
//  Accounts.swift
//  Blau
//
//  Created by Joe Blau on 6/19/24.
//

import SwiftUI

@Observable class Settings {
    var emailAddress: String? = UserDefaults.standard.string(forKey: "application_open_count") {
        didSet {
            UserDefaults.standard.setValue(emailAddress, forKey: "application_email_address")
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