// StripeView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct StripeView: View {
    @Environment(\.dismiss) private var dismiss

    var address: String

    var body: some View {
        NavigationView {
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
        }
    }
}

#Preview {
    StripeView(address: "0xa53417F20BB7148a50849770471De251417C3F12")
}
