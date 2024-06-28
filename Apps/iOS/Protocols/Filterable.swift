// Filterable.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

protocol Filterable: CaseIterable, Identifiable, Equatable {
    var title: String { get }
    var systemImage: String { get }
    var color: Color { get }
}
