// StripeView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct StripeView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            switch capsuleManager.wallet?.address {
            case let .some(address):
                WebViewItem(urlString: ONRAMP_STRIPE(address: address))
                    .navigationTitle("Buy with Stripe")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                Label("Close", systemImage: "x.mark")
                            }
                        }
                    }
            case .none:
                NoWalletItem()
            }
        }
    }
}

#Preview {
    StripeView()
}
