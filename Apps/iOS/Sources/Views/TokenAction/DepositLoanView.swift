// DepositLoanView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct DepositLoanView: View {
    @Environment(\.settings) var settings

    var body: some View {
        Text("Deposit Loan")

        Button {
            settings.presented = nil
        } label: {
            Text("Deposit")
        }
    }
}

#Preview {
    DepositLoanView()
}
