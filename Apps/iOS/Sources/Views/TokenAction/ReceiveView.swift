// ReceiveView.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct ReceiveView: View {
    @EnvironmentObject var capsuleManager: CapsuleManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            switch capsuleManager.wallet {
            case let .some(wallet):
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
                            Label("Close", systemImage: "xmark")
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
    ReceiveView()
}
