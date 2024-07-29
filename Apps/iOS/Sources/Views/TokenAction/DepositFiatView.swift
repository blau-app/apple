// DepositFiatView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct DepositFiatView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager

    var body: some View {
        switch capsuleManager.wallet?.address {
        case let .some(address):
            WebViewItem(urlString: ONRAMP_STRIPE(address: address))
        case .none:
            NoWalletItem()
        }
    }
}

#Preview {
    DepositFiatView()
}
