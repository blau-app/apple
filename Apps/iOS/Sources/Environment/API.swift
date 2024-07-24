// API.swift
// Copyright (c) 2024 Party Labs, Inc

import GRPC
import NIOPosix
import SwiftUI

@Observable class API {
    private let client: Superdapp_PitBossAsyncClient

    init() {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        defer {
            try? group.syncShutdownGracefully()
        }

        do {
            let channel = try GRPCChannelPool.with(
                target: .host("localhost", port: 17001),
                transportSecurity: .tls(.makeClientConfigurationBackedByNIOSSL()),
                eventLoopGroup: group
            )

            defer {
                try? channel.close().wait()
            }

            client = Superdapp_PitBossAsyncClient(channel: channel)
        } catch {
            fatalError("can not setup api client")
        }
    }

    func getTokenBundles(addresses: [String]) async throws -> [TokenBundle] {
        let request = Superdapp_GetTokenBundlesRequest.with {
            $0.evmPublicKeys = addresses
        }

        let responseStream = client.getTokenBundles(request)

        for try await response in responseStream {
            print(response.tokenBundles.count)
        }
//        let bundles = superdapp.
//
//        bundles.map { bundle in
//            bundle.
//        }

//        guard let URL = URL(string: "https://balance.api.blau.app/v1") else { return .init() }
//        var request = URLRequest(url: URL)
//        request.httpMethod = "POST"
//        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        let bodyObject: [String: Any] = [
//            "publicKeys": addresses,
//        ]
//        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
//
//        let (data, response) = try await session.data(for: request)
//        guard let response = response as? HTTPURLResponse,
//              response.statusCode == 200 else { return .init() }
//
//        let balanceResponses = try JSONDecoder().decode([BalanceResponse].self, from: data)
//
//        return balanceResponses.map { balanceResponse in
//            TokenBundle(tokensIn: [balanceResponse.toToken], actions: [.loan, .stake, .addLiquidity])
//        }
        return []
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
