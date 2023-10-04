//
//  Configurable.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation

public protocol Configurable { }

public extension Configurable {
    func configure(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Configurable { }
