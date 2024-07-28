// TokenBundleItem.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct TokenBundleItem: View {
    var nft = RoundedRectangle(cornerRadius: 12, style: .continuous)
    var ft = Circle()
    @Environment(\.settings) private var settings
    @Environment(\.colorScheme) private var colorScheme
    @Binding var tokenBundle: TokenBundle

    var body: some View {
        VStack(spacing: 8) {
            switch (tokenBundle.tokensIn.count, tokenBundle.tokensOut?.count ?? 0) {
            case (2, 0): headerLink(label: "Pair", tokenBundle: tokenBundle)
            case (2..., 0): headerLink(label: "Pool", tokenBundle: tokenBundle)
            case (1, 1...) where tokenBundle.tokensIn.first?.address == tokenBundle.tokensOut?.first?.address:
                headerLink(label: "Stake", tokenBundle: tokenBundle)
            case (1, 1): headerLink(label: "Borrow", tokenBundle: tokenBundle)
            case (1..., 1...): headerLink(label: "Farm", tokenBundle: tokenBundle)
            default: EmptyView()
            }
            tokenBundle(tokens: tokenBundle.tokensIn)
            if let tokensOut = tokenBundle.tokensOut {
                Image(systemName: "chevron.compact.down").foregroundColor(.secondary)
                tokenBundle(tokens: tokensOut)
            }
        }
        .contextMenu(menuItems: {
            ForEach(tokenBundle.actions) { action in
                Button(action: {
                    settings.presented = .tokenAction(action)
                }, label: {
                    action.label
                })
            }
        })
    }

    func headerLink(label: String, tokenBundle: TokenBundle) -> some View {
        NavigationLink(destination: EmptyView()) {
            LabeledContent {
                Text(tokenBundle.balance.fiat.usd())
                    .foregroundColor(.secondary)
                    .font(.system(.body, design: .rounded).monospacedDigit())
                    .privacySensitive()
            } label: {
                Text(label)
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
            }
        }
    }

    func tokenBundle(tokens: [Token]) -> some View {
        VStack(spacing: -4) {
            ForEach(Array(tokens.enumerated()), id: \.element.id) { _, token in
                switch token.erc {
                case .erc20: erc20Single(token: token)
                case .erc721, .erc1155: erc721Single(token: token)
                }
            }
        }
    }

    func erc721Single(token: Token) -> some View {
        LabeledContent {
            VStack(alignment: .trailing) {
                Text(token.balance.fiat.usd())
                    .foregroundColor(.primary)
                    .font(.system(.body, design: .rounded).monospacedDigit())
                    .privacySensitive()
                Text(token.balance.value.formatted())
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .monospaced()
                    .privacySensitive()
            }
        } label: {
            HStack {
                AsyncImageItem(imageURI: token.logoURI)
                    .clipShape(nft)
                    .overlay(
                        nft.stroke(colorScheme.ringColor, lineWidth: 2)
                    )
                VStack(alignment: .leading) {
                    Text(token.symbol).font(.system(.headline, design: .rounded))
                    Text(token.name)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
        }
    }

    func erc20Single(token: Token) -> some View {
        LabeledContent {
            VStack(alignment: .trailing) {
                Text(token.balance.fiat.usd())
                    .foregroundColor(.primary)
                    .font(.system(.body, design: .rounded).monospacedDigit())
                    .privacySensitive()
                Text(token.formattedBalance.value.formatted())
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .monospaced()
                    .privacySensitive()
            }
        } label: {
            HStack {
                AsyncImageItem(imageURI: token.logoURI)
                    .clipShape(ft)
                    .overlay(
                        ft.stroke(colorScheme.ringColor, lineWidth: 2)
                    )
                VStack(alignment: .leading) {
                    Text(token.symbol).font(.system(.headline, design: .rounded))
                    Text(token.name)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
        }
    }
}

// #Preview {
//    TokenBundleItem(tokenBundle: .constant(TokenBundle(tokensIn: [ethereumToken])))
// }
