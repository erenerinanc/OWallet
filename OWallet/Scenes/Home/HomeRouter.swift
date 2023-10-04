//
//  HomeRouter.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

import Foundation
import UIKit

protocol HomeRoutingLogic {
    func openModal(type: ModalType, selectedIndex: Int?)
    func routeToDetail(index: Int)
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get set}
}

class HomeRouter: HomeRoutingLogic,
                  HomeDataPassing {

    var dataStore: HomeDataStore?
    weak var viewController: HomeViewController?
    
    func openModal(type: ModalType, selectedIndex: Int?) {
        let vc = ModalController(type: type, selectedIndex: selectedIndex)
        vc.delegate = viewController as (any ModalControllerDelegate)?
        viewController?.showDetailViewController(vc, sender: self)
    }
    
    func routeToDetail(index: Int) {
        guard let coin = dataStore?.coins?[index] else { return }
        
        let vc = DetailViewController(businessModel: DetailBusinessModel(coin: coin))
        viewController?.show(vc, sender: self)
 
    }
}
