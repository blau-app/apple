// String+.swift
// Copyright (c) 2024 Superdapp, Inc

import CryptoKit
import SwiftUI

extension String {
    func shortAddress() -> String {
        "\(prefix(6).description)••••\(suffix(4).description)"
    }

    func getQRCodeData() -> Data? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = self.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }

    var digits: [Int] {
        var result = [Int]()

        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }

        return result
    }

    func isValidENSName() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-z0-9]+[a-z0-9-]*[a-z0-9]+\\.eth$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }

    var noSpace: String {
        components(separatedBy: .whitespacesAndNewlines).joined()
    }

    var sha256: String {
        let data = Data(utf8)
        let hash = SHA256.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
