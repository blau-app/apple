//
//  Presented.swift
//  Blau
//
//  Created by Joe Blau on 6/23/24.
//

import Foundation

enum Presented: CaseIterable, Identifiable {
    var id: Self { self }
    case onboarding
    case accounts
}
