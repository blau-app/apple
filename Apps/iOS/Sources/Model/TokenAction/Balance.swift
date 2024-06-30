// Balance.swift
// Copyright (c) 2024 Party Labs, Inc

import Foundation

struct Balance: Identifiable, Codable, Equatable, Hashable {
    var id: UUID { UUID() }
    var value: Double = 0.0
    var fiat: Double = 0.0
}
