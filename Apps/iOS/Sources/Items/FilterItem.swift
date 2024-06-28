// FilterItem.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

struct FilterItem<T: Filterable>: View {
    @Binding var filter: T
    let allCases: [T]

    init(filter: Binding<T>) {
        _filter = filter
        allCases = Array(T.allCases)
    }

    var body: some View {
        HStack {
            ForEach(allCases) { filterCase in
                FilterButton(by: filterCase)
            }
        }
    }

    func FilterButton(by: T) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                filter = by
            }
        } label: {
            switch filter == by {
            case true:
                by.label
                    .font(.headline)
                    .frame(height: 24)
                    .labelStyle(.titleAndIcon)
                    .frame(maxWidth: .infinity)
            case false:
                by.label
                    .font(.headline)
                    .frame(height: 24)
                    .labelStyle(.iconOnly)
            }
        }
        .controlSize(.extraLarge)
        .buttonStyle(.borderedProminent)
        .foregroundColor(filter == by ? .white : .secondary)
        .tint(filter == by ? by.color : Color(UIColor.tertiarySystemFill))
    }
}

#Preview {
    @State var accountTypes: AccountTypeFilter = .allKeys
    @State var tokenTypes: TokenTypeFilter = .allTokens
    return VStack {
        FilterItem(filter: $accountTypes)
        FilterItem(filter: $tokenTypes)
    }
}
