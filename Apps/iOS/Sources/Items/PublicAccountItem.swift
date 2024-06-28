// PublicAccountItem.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

struct PublicAccountItem: View {
    var publicAccount: PublicAccount

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
                avatarBeam.createAvatarView(name: publicAccount.address, size: 40)
                VStack(alignment: .leading) {
                    Text(publicAccount.address.shortAddress())
                        .font(.headline)
                        .monospaced()
                    Text(publicAccount.name)
                        .font(.system(.subheadline, design: .rounded))
                }
                .privacySensitive()
            }
        }
    }
}

#Preview {
    PublicAccountItem(publicAccount: PublicAccount(name: "vitalik.eth",
                                                   address: "0xd8da6bf26964af9d7eed9e03e53415d37aa96045"))
}
