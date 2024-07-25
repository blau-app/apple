// OnboardStakeView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct OnrampStakeView: View {
    @Environment(\.settings) var settings
    
    @State var tokenBundle = TokenBundle(tokensIn: [Token()],
                                         actions: [.depositStake])

    var body: some View {
        List {
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

#Preview {
    OnrampStakeView()
}
