//
//  ModalTypes.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

import Foundation

enum ModalType: Equatable {
    case listing(items: [ListingType] = ListingType.allCases)
    case sorting(items: [SortingType] = SortingType.allCases)
}

protocol ModalDisplayLogic {
    var value: String { get }
}

// MARK: - Listing
enum ListingType: CaseIterable {
    case volume24h
    case marketCap
    case price
}

extension ListingType: ModalDisplayLogic {
    var value: String {
        switch self {
        case .volume24h:
            return "24H Volume"
        case .marketCap:
            return "Market Capital"
        case .price:
            return "Price"
        }
    }
}

// MARK: - Sorting
enum SortingType: CaseIterable {
    case lowest
    case highest
}

extension SortingType: ModalDisplayLogic {
    var value: String {
        switch self {
        case .lowest:
            return "Lowest To Highest"
        case .highest:
            return "Highest To Lowest"
        }
    }
}
