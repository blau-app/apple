// OnrampSuccessView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct OnrampSuccessView: View {
    @Environment(\.settings) var settings

    @State var tokenBundles = [
        TokenBundle(tokensIn: [Token()],
                    tokensOut: [Token()],
                    actions: []),
        TokenBundle(tokensIn: [Token()],
                    tokensOut: [Token()],
                    actions: []),
        TokenBundle(tokensIn: [Token()],
                    actions: []),
    ]

    var body: some View {
        List {
            ForEach($tokenBundles) { $tokenBundle in
                Section {
                    TokenBundleItem(tokenBundle: $tokenBundle)
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
            }
        }
        .listSectionSpacing(LIST_SECTION_SPACING)
    }
}

#Preview {
    OnrampSuccessView()
}
