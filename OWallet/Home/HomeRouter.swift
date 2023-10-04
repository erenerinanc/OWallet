//
//  HomeRouter.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

import Foundation

protocol HomeRoutingLogic {
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get set}
}

class HomeRouter: HomeRoutingLogic,
                  HomeDataPassing {
    
    var dataStore: HomeDataStore?
    weak var viewController: HomeViewController?
}

