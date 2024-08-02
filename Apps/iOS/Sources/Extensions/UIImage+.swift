//
//  UIImage+.swift
//  Superdapp
//
//  Created by Joe Blau on 8/1/24.
//

import UIKit

extension UIImage {
    static var appIcon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
              let lastIcon = iconFiles.last else {
            return nil
        }
        return UIImage(named: lastIcon)
    }
}
