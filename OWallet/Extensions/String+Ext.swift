//
//  String+Ext.swift
//  OWallet
//
//  Created by Eren Erinanç on 3.10.2023.
//

import Foundation

extension String {
    func convertToDouble() -> Double? {
        return Double(self)
    }
}

extension Double {
    func convertToTwoDecimalString() -> String? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        return formatter.string(for: self)
    }
}
