// Action.swift
// Copyright (c) 2024 Superdapp, Inc

//
//  Action.swift
//  TokensNotDapps
//
//  Created by Joe Blau on 5/30/24.
//

import SwiftUI

enum Action: Int, Identifiable, CaseIterable, Codable, CustomStringConvertible {
    case send = 1
    case receive
    case mint
    case burn
    case vote
    case delegate
    case collect
    case approve
    case revoke
    case swap
    case borrow
    case repay
    case depositStake
    case withdrawStake
    case depositLoan
    case withdrawLoan
    case depositLiquidity
    case withdrawLiquidity
    case depositFarm
    case withdrawFarm

    var id: Int { rawValue }

    var description: String {
        switch self {
        case .send: "Send"
        case .receive: "Receive"
        case .mint: "Mint"
        case .burn: "Burn"
        case .vote: "Vote"
        case .delegate: "Delegate"
        case .collect: "Collect"
        case .approve: "Approve"
        case .revoke: "Revoke"
        case .swap: "Swap"
        case .borrow: "Borrow"
        case .repay: "Repay"
        case .depositStake: "Deposit Stake"
        case .withdrawStake: "Withdraw Stake"
        case .depositLoan: "Deposit Loan"
        case .withdrawLoan: "Withdraw Loan"
        case .depositLiquidity: "Deposit Liquidity"
        case .withdrawLiquidity: "Withdraw Liquidity"
        case .depositFarm: "Deposit Farm"
        case .withdrawFarm: "Withdraw Farm"
        }
    }

    var systemImage: String {
        switch self {
        case .send: "paperplane"
        case .receive: "qrcode.viewfinder"
        case .mint: "plus.circle"
        case .burn: "flame"
        case .vote: "vote"
        case .delegate: "person.2"
        case .collect: "dollarsign.circle"
        case .approve: "hand.thumbsup"
        case .revoke: "hand.thumbsdown"
        case .swap: "arrow.2.squarepath"
        case .borrow: "arrow.down.to.line"
        case .repay: "arrow.up.to.line"
        case .depositStake, .depositLoan, .depositLiquidity, .depositFarm: "arrow.down.to.line.alt"
        case .withdrawStake, .withdrawLoan, .withdrawLiquidity, .withdrawFarm: "arrow.up.to.line.alt"
        }
    }

    @ViewBuilder
    var label: some View {
        switch self {
        case .vote:
            Label(description, image: systemImage)
        default:
            Label(description, systemImage: systemImage)
        }
    }
}
