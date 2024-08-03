// HeroItem.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct HeroItem: View {
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        Image("hero")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .offset(x: -scrollOffset / 2) // Parallax effect
            .clipped()
            .ignoresSafeArea()
    }
}

#Preview {
    HeroItem()
}
