//
//  DetailInteractor.swift
//  OWallet
//
//  Created Eren Erinanç on 2.10.2023.

import Foundation

protocol DetailBusinessLogic {
}

protocol DetailDataStore: AnyObject {
}

class DetailInteractor: DetailBusinessLogic,
												 DetailDataStore {
	
	var presenter: DetailPresentationLogic
	var worker: DetailWorkingLogic
    
    init(presenter: DetailPresentationLogic,
         worker: DetailWorkingLogic) {
        self.presenter = presenter
        self.worker = worker
    }
	
}



