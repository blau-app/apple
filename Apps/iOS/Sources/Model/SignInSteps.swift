// SignInSteps.swift
// Copyright (c) 2024 Superdapp, Inc

enum SignInSteps: Identifiable {
    var id: Self { self }
    case signin
    case email
    case verification
    case welcome
}
