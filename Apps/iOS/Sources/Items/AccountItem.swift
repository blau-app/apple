// AccountItem.swift
// Copyright (c) 2024 Superdapp, Inc

import CapsuleSwift
import SwiftUI

struct AccountItem: View {
    var account: Account
    private let avatarBeam = AvatarBeam()

    var body: some View {
        LabeledContent {
            Button {} label: {
                Image(systemName: "doc.on.doc").padding(8)
            }
            Button {} label: {
                Image(systemName: "qrcode").padding(8)
            }
        } label: {
            HStack {
                switch account.type {
                case let .wallet(wallet):
                    WalletAccount(wallet: wallet)
                case let .watch(watch):
                    WatchAccount(watch: watch)
                }
            }
        }
    }

    @ViewBuilder
    func WalletAccount(wallet: Wallet) -> some View {
        switch wallet.address {
        case let .some(address): avatarBeam.createAvatarView(name: address, size: 40)
        case .none: Image(systemName: "exclamationmark.triangle")
        }
        VStack(alignment: .leading) {
            Text(wallet.address?.shortAddress() ?? "0x0000••••0000")
                .font(.headline)
                .monospaced()
            Text("\(Image(systemName: "key.fill")) Key on device")
                .font(.system(.subheadline, design: .rounded))
        }
        .privacySensitive()
    }

    @ViewBuilder
    func WatchAccount(watch: Watch) -> some View {
        avatarBeam.createAvatarView(name: watch.address, size: 40)
        VStack(alignment: .leading) {
            Text(watch.address.shortAddress())
                .font(.headline)
                .monospaced()
            Text(watch.name)
                .font(.system(.subheadline, design: .rounded))
        }
        .privacySensitive()
    }
}

#Preview {
    List {
        AccountItem(account: Account(id: "1", wallet: Wallet(id: "9ed25c98-f5b2-499e-a19c-8931b5d1a656",
                                                             signer: nil,
                                                             address: "0x505a777687665e6acf348fa9eb6a48653ae61ed9",
                                                             publicKey: "0x040267bd29a6c98bbf349adfb536ad5893762ab71b60d09165b9b155d6d7420f0cd0003ae61da924936b7dbd63f627ab4bd3e0cf864a1870d4dc73cd5200247639")))

        AccountItem(account: Account(id: "2", watch: Watch(name: "vitalik.eth",
                                                           address: "0xd8da6bf26964af9d7eed9e03e53415d37aa96045")))
    }
}
