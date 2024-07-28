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
        case .send: .send
        case .receive: .receive
        case .mint: .mint
        case .burn: .burn
        case .vote: .vote
        case .delegate: .delegate
        case .collect: .collect
        case .approve: .approve
        case .revoke: .revoke
        case .swap: .swap
        case .borrow: .borrow
        case .repay: .repay
        case .depositFiat: .depositFiat
        case .depositStake: .depositStake
        case .depositLoan: .depositLoan
        case .depositLiquidity: .depositLiquidity
        case .depositFarm: .depositFarm
        case .pauseFiat: .pauseFiat
        case .pauseStake: .pauseStake
        case .pauseLoan: .pauseLoan
        case .pauseLiquidity: .pauseLiquidity
        case .pauseFarm: .pauseFarm
        case .withdrawFiat: .withdrawFiat
        case .withdrawStake: .withdrawStake
        case .withdrawLoan: .withdrawLoan
        case .withdrawLiquidity: .withdrawLiquidity
        case .withdrawFarm: .withdrawFarm
        }
    }
}

extension V1GetTokenBundlesPost200ResponseTokenBundlesInnerInInnerBalance {
    var toBalance: Balance {
        Balance(value: Double(value) ?? 0.0, fiat: fiat)
    }
}
