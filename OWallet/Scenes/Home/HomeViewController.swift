//
//  HomeViewController.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayCoins(viewModel: Home.ViewModel)
    func displayError(title: String, message: String)
}

// MARK: View

class HomeViewController: BaseViewController {
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var items: [HomeCollectionViewCell.ViewModel]?
    
    lazy var listItem = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(list)).configure {
        $0.tintColor = .systemPurple
    }
    lazy var sortItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sort)).configure {
        $0.tintColor = .systemPurple
    }
    lazy var collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: UICollectionView.makeVerticalLayout(cellHeight: 80)).configure {
        $0.delegate = self
        $0.dataSource = self
    }
    var selectedListingIndex: Int?
    var selectedSortingIndex: Int?
    
    // MARK: View lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUp()
        configureUI()
        collectionView.register(HomeCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeCollectionViewCell.reuseId)
        interactor?.fetchCoins()
    }
    
    private func setNavigationBar() {
        title = Constants.homeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [listItem, sortItem]
    }
    
    @objc func list() {
        router?.openModal(type: .listing(), selectedIndex: selectedListingIndex)
    }
    
    @objc func sort() {
        router?.openModal(type: .sorting(), selectedIndex: selectedSortingIndex)
    }
    
    private func setUp() {
        let presenter = HomePresenter()
        let worker = HomeWorker(networkable: NetworkManager(decoder: JSONDecoder(),
                                                            session: URLSession.shared))
        let interactor = HomeInteractor(presenter: presenter,
                                        worker: worker)
        let router = HomeRouter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.router = router
        router.viewController = self
        router.dataStore = interactor
    }
    
    // MARK: SetupUI
    private func configureUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

// MARK: HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displayCoins(viewModel: Home.ViewModel) {
        self.items = viewModel.items
        collectionView.reloadData()
    }
    
    func displayError(title: String, message: String) {
        showError(title: title, message: message)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseId, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let cellModel = items?[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.set(viewModel: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToDetail(index: indexPath.item)
    }
}

// MARK: - ModalControllerDelegate
extension HomeViewController: ModalControllerDelegate {
    func didSelectItem(type: ModalType, index: Int) {
        switch type {
        case .listing:
            selectedListingIndex = index
            listItem.tintColor = .systemGreen
        case .sorting:
            selectedSortingIndex = index
            sortItem.tintColor = .systemGreen
        }
        interactor?.listOrSort(type: type, index: index)
    }
}
