//
//  DetailViewController.swift
//  OWallet
//
//  Created Eren Erinanç on 2.10.2023.

import UIKit

protocol DetailDisplayLogic: AnyObject {
}

// MARK: View
public class DetailViewController: UIViewController {
	var interactor: DetailBusinessLogic?
	var router: (DetailRoutingLogic & DetailDataPassing)?
	var viewModel: Detail.ViewModel?
    
    // MARK: View lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUP()
    }
    
    // MARK: SetupUI
    private func setUP() {
        let presenter = DetailPresenter()
        let worker = DetailWorker(networkable: NetworkManager(decoder: JSONDecoder(),
                                                              session: URLSession.shared))
        let interactor = DetailInteractor(presenter: presenter,
                                          worker: worker)
        let router = DetailRouter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.router = router
        router.viewController = self
        router.dataStore = interactor
        
    }
}

// MARK: DetailDisplayLogic
extension DetailViewController: DetailDisplayLogic {
    
}
