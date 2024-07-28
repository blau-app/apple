// DepositStakeView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct DepositStakeView: View {
    @Environment(\.settings) var settings

    var body: some View {
        Text("Deposit Stake")

        Button {
            settings.presentedFullScreen = nil
        } label: {
            Text("Deposit")
        }
    }
}

#Preview {
    DepositStakeView()
}
