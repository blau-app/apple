// Double+.swift
// Copyright (c) 2024 Superdapp, Inc

import Foundation

extension Double {
    func usd() -> String {
        if self > 0.01 {
            return formatted(.currency(code: "usd"))
        } else {
            let str = formatted(.number.precision(.fractionLength(18)))

            // Split the string by the decimal point
            let parts = str.split(separator: ".")
            guard parts.count == 2 else { return "$\(str)" }

            // Extract the fractional part
            let fractionalPart = String(parts[1])

            // Find the number of zeros between the decimal and the first non-zero number
            var zeroCount = 0
            for char in fractionalPart {
                if char == "0" {
                    zeroCount += 1
                } else {
                    break
                }
            }

            if zeroCount == fractionalPart.count {
                return 0.0.formatted(.currency(code: "usd"))
            }

            // If there are no zeros or only one zero, return the original string
            if zeroCount <= 1 {
                return "$\(str)"
            }

            // Construct the subscript string
            let subscriptNumbers = ["₀", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉"]
            var subscriptString = ""
            for digit in String(zeroCount) {
                if let index = Int(String(digit)) {
                    subscriptString += subscriptNumbers[index]
                }
            }

            // Construct the final string
            let remainingFraction = fractionalPart.dropFirst(zeroCount).prefix(2)
            return "$\(parts[0]).0\(subscriptString)\(remainingFraction)"
        }
    }
}
