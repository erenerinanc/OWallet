//
//  DetailPresenter.swift
//  OWallet
//
//  Created Eren Erinanç on 2.10.2023.

protocol DetailPresentationLogic: AnyObject {
}

class DetailPresenter: DetailPresentationLogic {
	
	weak var viewController: DetailDisplayLogic?
}
