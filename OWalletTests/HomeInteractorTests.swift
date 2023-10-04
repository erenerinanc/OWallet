//
//  HomeInteractorTestsInteractorTests
//  OWallet
//
//  Created Eren Erinanç on 4.10.2023.

import XCTest
@testable import OWallet

final class HomeInteractorTests: XCTestCase {
    /// subject under test
    private var sut: HomeInteractor!
    private var presentationLogicSpy: HomePresentationLogicSpy = HomePresentationLogicSpy()
    private var workingLogicSpy: HomeWorkingLogicSpy!
    private var networkableProtocol: NetworkableProtocol!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }
    
    private func setupInteractor() {
        workingLogicSpy = createWorkerSpy()
        sut = HomeInteractor(presenter: presentationLogicSpy,
                             worker: workingLogicSpy)
        
        sut.presenter = presentationLogicSpy
    }
    
    private func createWorkerSpy() -> HomeWorkingLogicSpy {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        networkableProtocol = NetworkManager(decoder: JSONDecoder(), session: urlSession)
        return HomeWorkingLogicSpy(networkable: networkableProtocol)
    }
    
//    func testFetchCoins_Success() {
//        // Given
//        let workerSpy = createWorkerSpy()
//        workerSpy.url = Mocks.home.url
//        sut.worker = workerSpy
//        sut.presenter = presentationLogicSpy
////        let coins: [Coin] = [.init(uuid: "testuuid",
////                                   symbol: "TestXX",
////                                   name: "TestCoin",
////                                   color: "hex",
////                                   iconURL: "URLTest",
////                                   marketCap: "333.333",
////                                   price: "44.4",
////                                   listedAt: 333,
////                                   tier: 22,
////                                   change: "-4.4",
////                                   rank: 3,
////                                   sparkline: ["333,333","3333.333"],
////                                   lowVolume: true,
////                                   coinrankingURL: "URL",
////                                   the24HVolume: "44444.4444",
////                                   btcPrice: "333333333"),
////                             .init(uuid: "testuuid2",
////                                   symbol: "TestXX2",
////                                   name: "TestCoin2",
////                                   color: "hex2",
////                                   iconURL: "URLTest2",
////                                   marketCap: "333.334",
////                                   price: "44.45",
////                                   listedAt: 3334,
////                                   tier: 223,
////                                   change: "-4.45",
////                                   rank: 33,
////                                   sparkline: ["333,333","3333.333555"],
////                                   lowVolume: false,
////                                   coinrankingURL: "URL2",
////                                   the24HVolume: "44444.4444333",
////                                   btcPrice: "333333334433")]
//        // When
//        sut.fetchCoins()
//        // Then
//        wait(for: 2) {
//            XCTAssertTrue(presentationLogicSpy.isPresentCoinsCalled)
//            XCTAssertEqual(presentationLogicSpy.coins?.first?.uuid, "Qwsogvtv82FCd")
//            XCTAssertEqual(presentationLogicSpy.coins?.first?.symbol, "BTC")
//            XCTAssertEqual(presentationLogicSpy.coins?.last?.marketCap,"3764341025")
//            XCTAssertEqual(presentationLogicSpy.coins?.last?.color, "3764341025")
//            XCTAssertEqual(presentationLogicSpy.coins?.last?.sparkline?.count, 27)
//            XCTAssertEqual(presentationLogicSpy.coins?.last?.tier, 1)
//            XCTAssertEqual(presentationLogicSpy.coins?.last?.lowVolume, false)
//        }
// 
//    }
    
    func testFetchCoins_Fail() {
        
    }
    
}

extension XCTestCase {
    func wait(for sec: TimeInterval, completion: (()-> ())) {
        let exp = expectation(description: "Test after \(sec) seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: sec)
        if result == XCTWaiter.Result.timedOut {
            completion()
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
