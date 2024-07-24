// Presented.swift
// Copyright (c) 2024 Superdapp, Inc

import Foundation

enum Presented: CaseIterable, Identifiable {
    var id: Self { self }
    case accounts
    case addAccount
}
