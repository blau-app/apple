// DepositFiatView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct DepositFiatView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var capsuleManager: CapsuleManager

    var body: some View {
        switch capsuleManager.wallet?.address {
        case let .some(address):
            #if targetEnvironment(simulator)
                WebViewItem(urlString: ONRAMP_STRIPE_PREVIEW(address: address))
            #else
                WebViewItem(urlString: ONRAMP_STRIPE(address: address))
            #endif
        case .none:
            NoWalletItem()
        }
    }
}

#Preview {
    DepositFiatView()
}
