// Authenticate.swift
// Copyright (c) 2024 Superdapp, Inc

import LocalAuthentication
import SwiftUI

@Observable class Authenticate: NSObject {
    let context = LAContext()

    func authenticate(completion: @escaping (Bool) -> Void) {
        completion(true)

//        var error: NSError?
//
//        // check whether biometric authentication is possible
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            // it's possible, so go ahead and use it
//            let reason = "We need to unlock your data."
//
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    completion(success)
//                }
//            }
//        } else {
//            // no biometrics
//        }
    }
}

struct AuthenticateKey: EnvironmentKey {
    static let defaultValue: Authenticate = .init()
}

extension EnvironmentValues {
    var auth: Authenticate {
        get { self[AuthenticateKey.self] }
        set { self[AuthenticateKey.self] = newValue }
    }
}
