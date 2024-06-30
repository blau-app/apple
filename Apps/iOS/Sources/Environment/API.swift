// API.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

@Observable class API {
    let session = URLSession(configuration: URLSessionConfiguration.default,
                             delegate: nil,
                             delegateQueue: nil)

    func getTokenBundles(addresses _: [String]) -> [TokenBundle] {
        .init()
    }
}

struct APIKey: EnvironmentKey {
    static let defaultValue: API = .init()
}

extension EnvironmentValues {
    var api: API {
        get { self[APIKey.self] }
        set { self[APIKey.self] = newValue }
    }
}
