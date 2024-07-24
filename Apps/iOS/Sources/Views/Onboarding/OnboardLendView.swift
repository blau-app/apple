// OnboardLendView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct OnboardLendView: View {
    @Environment(\.system) var system
    @State var tokenBundle = TokenBundle(tokensIn: [Token()],
                                         actions: [.depositLoan])
    var body: some View {
        List {
            TokenBundleItem(tokenBundle: $tokenBundle)
                .contextMenu(menuItems: {
                    ForEach(tokenBundle.actions) { action in
                        Button(action: {
                            system.presentedAction = action
                        }, label: {
                            action.label
                        })
                    }
                })
        }
    }
}

#Preview {
    OnboardLendView()
}
