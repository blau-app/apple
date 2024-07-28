// OpenAPI+.swift
// Copyright (c) 2024 Superdapp, Inc

import Foundation
import OpenAPIClient

extension V1GetTokenBundlesPost200ResponseTokenBundlesInner {
    var toTokenBundle: TokenBundle {
        let tokensIn = _in.map { $0.toToken }
        let tokensOut = out?.map { $0.toToken }

        return TokenBundle(
            tokensIn: tokensIn,
            tokensOut: tokensOut,
            actions: actions.map { $0.toAction }
        )
    }
}

extension V1GetTokenBundlesPost200ResponseTokenBundlesInnerInInner {
    var toToken: Token {
        Token(
            erc: .erc20,
            address: address,
            chainId: chainId,
            name: name,
            symbol: symbol,
            decimals: decimals,
            balance: balance.toBalance
        )
    }
}

extension V1GetTokenBundlesPost200ResponseTokenBundlesInner.Actions {
    var toAction: Action {
        switch self {
        case .send: return .send
        case .receive: return .receive
        case .mint: return .mint
        case .burn: return .burn
        case .vote: return .vote
        case .delegate: return .delegate
        case .collect: return .collect
        case .approve: return .approve
        case .revoke: return .revoke
        case .swap: return .swap
        case .borrow: return .borrow
        case .repay: return .repay
        case .depositFiat, .depositStake, .depositLoan, .depositLiquidity, .depositFarm:
            return .depositStake // Using .depositStake as a general deposit action
        case .pauseFiat, .pauseStake, .pauseLoan, .pauseLiquidity, .pauseFarm:
            return .approve // Using .approve as there's no direct "pause" equivalent
        case .withdrawFiat, .withdrawStake, .withdrawLoan, .withdrawLiquidity, .withdrawFarm:
            return .withdrawStake // Using .withdrawStake as a general withdraw action
        }
    }
}

extension V1GetTokenBundlesPost200ResponseTokenBundlesInnerInInnerBalance {
    var toBalance: Balance {
        Balance(value: Double(value) ?? 0.0, fiat: fiat)
    }
}
