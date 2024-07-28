// Presented.swift
// Copyright (c) 2024 Superdapp, Inc

import Foundation

enum PresentedFullScreen: Identifiable {
    var id: Self { self }
    case stripe
    case receive
    case accounts
    case addAccount


//    var id: String {
//        switch self {
//        case .stripe: "stripe"
//        case .receive: "receive"
//        case .accounts: "accounts"
//        case .addAccount: "addAccount"
//        case let .tokenAction(action): "tokenAction_\(action.id)"
//        }
//    }
}
