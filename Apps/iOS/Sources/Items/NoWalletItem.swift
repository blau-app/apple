// NoWalletItem.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct NoWalletItem: View {
    var body: some View {
        ContentUnavailableView {
            Label("No Wallet", systemImage: "wallet.bifold")
                .symbolRenderingMode(.hierarchical)
        } description: {
            Text("You need a wallet to recieve funds")
        } actions: {
            Button {} label: {
                Label("Load Wallet", systemImage: "wallet.bifold")
            }
        }
    }
}

#Preview {
    NoWalletItem()
}
