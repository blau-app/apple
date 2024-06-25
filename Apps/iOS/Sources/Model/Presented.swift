// Presented.swift
// Copyright (c) 2024 Party Labs, Inc

import Foundation

enum Presented: CaseIterable, Identifiable {
    var id: Self { self }
    case onboarding
    case accounts
}
