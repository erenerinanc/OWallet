//
//  String+Ext.swift
//  OWallet
//
//  Created by Eren Erinanç on 3.10.2023.
//

import Foundation

enum ImageFormat: String {
    case svg = ".svg"
    case png = ".png"
}

extension String {
    func convertToDouble() -> Double? {
        return Double(self)
    }
    
    func formatIconURL() -> String {
        var iconURL = ""
        if self.hasSuffix(ImageFormat.svg.rawValue) {
            iconURL = self.replacingOccurrences(of: ImageFormat.svg.rawValue, with: ImageFormat.png.rawValue)
        } else if !self.hasSuffix(ImageFormat.png.rawValue) && !(self.hasSuffix(ImageFormat.svg.rawValue)) {
            iconURL = self + ImageFormat.png.rawValue
        } else {
            iconURL = self
        }
        return iconURL
    }
}
