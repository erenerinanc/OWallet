//
//  BaseViewController.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    func showError(title: String, message: String) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(.init(title: "Tamam", style: .default))
        show(alertVC, sender: nil)
    }
}
