//
//  AccountItem.swift
//  Blau
//
//  Created by Joe Blau on 6/27/24.
//

import SwiftUI
import CapsuleSwift

struct WalletItem: View {
    @Environment(\.colorScheme) private var colorScheme

    var wallet: Wallet
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
                switch wallet.address {
                case let .some(address): avatarBeam.createAvatarView(name: address,
                                                                       size: 48)
                    
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
        }
    }
}

#Preview {
    WalletItem(wallet: Wallet(id: "9ed25c98-f5b2-499e-a19c-8931b5d1a656",
                              signer: nil,
                              address: "0x505a777687665e6acf348fa9eb6a48653ae61ed9",
                              publicKey: "0x040267bd29a6c98bbf349adfb536ad5893762ab71b60d09165b9b155d6d7420f0cd0003ae61da924936b7dbd63f627ab4bd3e0cf864a1870d4dc73cd5200247639"))
}
