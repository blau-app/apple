//
//  ColorScheme+.swift
//  Blau
//
//  Created by Joe Blau on 6/27/24.
//

import SwiftUI

extension ColorScheme {
    var blendMode: BlendMode {
        switch self {
        case .dark: return .plusLighter
        case .light: return .plusDarker
        default: return .normal
        }
    }
    
    var ringColor: Color {
        switch self {
        case .dark: Color(UIColor.secondarySystemBackground)
        default: Color(UIColor.systemBackground)
        
        }
    }
}
