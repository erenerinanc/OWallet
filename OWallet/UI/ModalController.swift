//
//  FilterModalController.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

import Foundation
import UIKit

protocol ModalControllerDelegate: AnyObject {
    func didSelectItem(type: ModalType, index: Int)
}

class ModalController: BaseViewController {
    var type: ModalType?
    var items: [ModalDisplayLogic] = []
    var selectedIndex: Int?
    
    lazy var separatorView = UIView().configure {
        $0.backgroundColor = .systemGray
        $0.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(4)
        }
        $0.layer.cornerRadius = 2
    }
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: UICollectionView.makeVerticalLayout(cellHeight: 50)).configure {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .systemGray6
    }
    
    weak var delegate: ModalControllerDelegate?
    
    convenience init(type: ModalType, selectedIndex: Int?) {
        self.init(nibName: nil, bundle: nil)
        self.type = type
        switch type {
        case .listing(let items):
            self.items = items
        case .sorting(let items):
            self.items = items
        }
        self.selectedIndex = selectedIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ModalCollectionViewCell.self,
                                forCellWithReuseIdentifier: ModalCollectionViewCell.reuseId)
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemGray6
        
        let padding: CGFloat = 16
        
        view.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(padding)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(padding*2)
            make.leading.trailing.equalToSuperview().inset(padding)
            make.bottom.equalToSuperview().offset(padding)
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ModalController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModalCollectionViewCell.reuseId, for: indexPath) as? ModalCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == selectedIndex {
            cell.isSelectionMade = true
        }
        let text = items[indexPath.row].value
        cell.setTitle(text: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = self.type else { return }
        self.selectedIndex = indexPath.item
        delegate?.didSelectItem(type: type, index: indexPath.item)
        dismiss(animated: true)
    }
}

