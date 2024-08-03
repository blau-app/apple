// Text+.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

extension Text {
    func h1() -> some View {
        multilineTextAlignment(.center)
            .font(.system(size: 42, weight: .bold, design: .serif))
    }
}
