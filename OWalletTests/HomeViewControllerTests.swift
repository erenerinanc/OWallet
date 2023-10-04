//
//  HomeViewControllerTests
//  OWallet
//
//  Created Eren Erinanç on 4.10.2023.

import XCTest
@testable import OWallet

final class HomeViewControllerTests: XCTestCase {
    
    /// subject under test
    private var sut: HomeViewController!
    private var workingLogicSpy: HomeWorkingLogicSpy!
    private var businessLogicSpy: HomeBusinessLogicSpy!
    private var routingLogicSpy: HomeRoutingLogicSpy!
    private var networkableProtocol: NetworkableProtocol!
    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func setupViewController() {
        sut = HomeViewController()
        businessLogicSpy = HomeBusinessLogicSpy()
        routingLogicSpy = HomeRoutingLogicSpy()
        
        let presenter = HomePresenter()
        presenter.viewController = sut
        sut.interactor = businessLogicSpy
        sut.router = routingLogicSpy
    }

    
    func testSortDidTap() {
        // Given
        let index = 0
        sut.selectedSortingIndex = index
        // When
        sut.sort()
        // Then
        XCTAssertTrue(routingLogicSpy.openModalCalled)
        XCTAssertEqual(routingLogicSpy.type, .sorting())
        XCTAssertEqual(routingLogicSpy.selectedIndex, index)
    }
    
    func testListDidTap() {
        // Given
        let index = 0
        sut.selectedListingIndex = index
        // When
        sut.list()
        // Then
        XCTAssertTrue(routingLogicSpy.openModalCalled)
        XCTAssertEqual(routingLogicSpy.type, .listing())
        XCTAssertEqual(routingLogicSpy.selectedIndex, index)
    }
    
    func testDidSelectItemAt() {
        // Given
        let indexPath: IndexPath = .init(item: 0, section: 0)
        // When
        let collectionView = sut.collectionView
        sut.collectionView(collectionView, didSelectItemAt: indexPath)
        // Then
        XCTAssertTrue(routingLogicSpy.routeToDetailCalled)
        XCTAssertEqual(routingLogicSpy.index, indexPath.item)
    }
    
    func testDidSelectItem_ModalDelegate() {
        // Given
        let type: ModalType = .listing()
        let index = 1
        sut.interactor = businessLogicSpy
        // When
        sut.didSelectItem(type: type, index: index)
        // Then
        XCTAssertTrue(businessLogicSpy.isListOrSortCalled)
        XCTAssertEqual(businessLogicSpy.type, type)
        XCTAssertEqual(businessLogicSpy.index, index)
    }
}
