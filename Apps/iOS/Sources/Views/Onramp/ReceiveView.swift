// ReceiveView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct ReceiveView: View {
    @Environment(\.dismiss) private var dismiss

    var wallet: Wallet

    var body: some View {
        NavigationStack {
            List {
                Section {
                    AccountItem(account: Account(id: "", wallet: wallet))
                } header: {
                    Text("My Wallet")
                }

                Section {
                    Image(uiImage: UIImage(data: wallet.address!.getQRCodeData()!)!)
                        .resizable()
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                        .frame(maxWidth: 256, maxHeight: 256)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .headerProminence(.increased)
            .navigationTitle("Receive")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
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

// #Preview {
//    ReceiveView(account: Account(id: "1", wallet: Wallet()))
// }
