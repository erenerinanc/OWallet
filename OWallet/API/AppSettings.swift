//
//  AppSettings.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation

public enum AppSettings {
    public static var baseURLString: String = info(for: "Base Url")
    public static var baseURL: URL { URL(string: baseURLString)! }
}

extension AppSettings {
    fileprivate static func info(for key: String) -> String {
        if let info = (Bundle.main.infoDictionary?[key] as? String) {
            return info
        }
        return ""
    }
}
