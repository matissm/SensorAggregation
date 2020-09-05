//
//  Extensions.swift
//  SensorAggregation
//
//  Created by Matiss Mamedovs on 05/09/2020.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cString = cString.uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 1)])
        }
        
        if (cString.count != 6) {
            self.init(white: 10, alpha: alpha)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
