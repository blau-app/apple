// API.swift
// Copyright (c) 2024 Superdapp, Inc

import OpenAPIClient
import SwiftUI

@Observable class API {
    func getTokenBundles(addresses: [String]) async throws -> [TokenBundle] {
        OpenAPIClientAPI.basePath = "https://bundles.api.blau.app"
//        OpenAPIClientAPI.basePath = "http://localhost:17001"

        let postRequest = V1GetTokenBundlesPostRequest(evmPublicKeys: addresses)
        let requestBuilder = DefaultAPI.v1GetTokenBundlesPostWithRequestBuilder(v1GetTokenBundlesPostRequest: postRequest)
        let response = try await requestBuilder.execute()

        return response.body.tokenBundles.map { $0.toTokenBundle }
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
