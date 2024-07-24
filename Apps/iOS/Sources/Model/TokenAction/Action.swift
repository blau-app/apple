// Action.swift
// Copyright (c) 2024 Party Labs, Inc

//
//  Action.swift
//  TokensNotDapps
//
//  Created by Joe Blau on 5/30/24.
//

import SwiftUI

enum Action: Identifiable, CaseIterable, Codable, CustomStringConvertible {
    var id: Self { self }
    case manageServices
    case swap
    case addLiquidity
    case removeLiquidity
    case mine
    case depositStake
    case depositLoan
    case liquidate
    case borrow
    case addCollateral
    case repay
    case send
    case receive
    case limit
    case hedge
    case delegate
    case addCash
    case burn
    case end
    case vote
    case collect
    case farm

    var description: String {
        switch self {
        case .manageServices: "Manage Services"
        case .swap: "Swap"
        case .addLiquidity: "Add Liquidity"
        case .removeLiquidity: "Remove Liquidity"
        case .depositStake: "Stake"
        case .mine: "Mine"
        case .depositLoan: "Loan"
        case .liquidate: "Liquidate"
        case .borrow: "Borrow"
        case .addCollateral: "Add Collateral"
        case .repay: "Repay"
        case .send: "Send"
        case .receive: "Receive"
        case .limit: "Limit"
        case .hedge: "Hedge"
        case .delegate: "Delegate"
        case .addCash: "Add Cash"
        case .burn: "Burn"
        case .end: "End"
        case .vote: "Vote"
        case .collect: "Collect"
        case .farm: "Farm"
        }
    }

    var systemImage: String {
        switch self {
        case .manageServices: "rectangle.stack"
        case .swap: "arrow.left.arrow.right"
        case .addLiquidity: "plus"
        case .removeLiquidity: "minus"
        case .depositStake: "lock.badge.clock"
        case .mine: "pickaxe"
        case .depositLoan: "piggy-bank"
        case .liquidate: "atom"
        case .borrow: "hand-coins"
        case .addCollateral: "plus"
        case .repay: "minus"
        case .send: "paperplane"
        case .receive: "qrcode.viewfinder"
        case .limit: "arrow.left.and.line.vertical.and.arrow.right"
        case .hedge: "dollarsign.arrow.circlepath"
        case .delegate: "person.line.dotted.person"
        case .addCash: "dollarsign.square"
        case .burn: "flame"
        case .end: "octagon"
        case .vote: "vote"
        case .collect: "dollarsign.arrow.circlepath"
        case .farm: "piggy-bank"
        }
    }

    @ViewBuilder
    var label: some View {
        switch self {
        case .mine, .borrow, .depositLoan, .vote, .farm:
            Label(description, image: systemImage)
        default:
            Label(description, systemImage: systemImage)
        }
    }
}
