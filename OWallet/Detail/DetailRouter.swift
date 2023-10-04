//
//  DetailRouter.swift
//  OWallet
//
//  Created Eren Erinanç on 2.10.2023.

import Foundation

protocol DetailRoutingLogic {
}

protocol DetailDataPassing: AnyObject {
	var dataStore: DetailDataStore? { get set}
}

public class DetailRouter: DetailRoutingLogic,
											 DetailDataPassing {
	
	var dataStore: DetailDataStore?
	weak var viewController: DetailViewController?
}

