// Constants.swift
// Copyright (c) 2024 Superdapp, Inc

import Foundation

let CAPSULE_API_KEY = "0f344e4f3efae94db02f6f133f06c0a9"
let KEY_APPLICATION_EMAIL_ADDRESS = "application_email_address"
func BEAM_AVATAR(address: String) -> String {
    "https://avatar.blau.app/beam?name=\(address)"
}

func ONRAMP_STRIPE_PREVIEW(address: String) -> String {
    "https://test.onramp.superdapp.com/stripe/\(address)"
}

func ONRAMP_STRIPE(address: String) -> String {
    "https://onramp.superdapp.com/stripe/\(address)"
}

let SECTION_HEADER_PADDING: CGFloat = -20
let FILTER_HEIGHT: CGFloat = 20
let LIST_SECTION_SPACING: CGFloat = 12
