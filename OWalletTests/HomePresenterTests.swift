//
//  HomePresenterTestsPresenterTests
//  OWallet
//
//  Created Eren Erinanç on 4.10.2023.

import XCTest
@testable import OWallet

final class HomePresenterTests: XCTestCase {
    /// subject under test
    private var sut: HomePresenter!
    private var displayLogicSpy: HomeDisplayLogicSpy!
    
    override func setUp() {
        super.setUp()
        setUpPresenter()
    }
    
    private func setUpPresenter() {
        sut = HomePresenter()
        displayLogicSpy = HomeDisplayLogicSpy()
        sut.viewController = displayLogicSpy
    }
}
