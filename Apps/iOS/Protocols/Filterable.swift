// Filterable.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

protocol Filterable: CaseIterable, Identifiable, Equatable {
    var label: Label<Text, Image> { get }
    var color: Color { get }
}
