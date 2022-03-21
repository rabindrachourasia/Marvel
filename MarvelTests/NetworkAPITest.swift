//
//  NetworkAPITest.swift
//  MarvelTests
//
//  Created by Rabi Chourasia on 14/03/22.
//
import Foundation
import XCTest
@testable import Marvel
class NetworkAPITest: XCTestCase {
    var listData : [MarvelListResult] = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_marvel_cahracter_list_API() {
        let network = Network.init()
        let networkRequest = NetworkRequest.init(network)
        networkRequest.list(offset: 0) { (result) in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    XCTAssertTrue(response.data != nil)
                    XCTAssertTrue((response.data?.results ?? []).count > 0)
                    self.listData = response.data?.results ?? []
                }
            case .failure(_):
                DispatchQueue.main.async {
                    XCTAssertFalse(self.listData.count > 0)
                }
            }
        }
    }

    func test_marvel_character_list_details_API(){
        let network = Network.init()
        let networkRequest = NetworkRequest.init(network)
        networkRequest.details(id: 0) { (result) in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    XCTAssertNotNil(response)
                }
            
            case .failure(_):
                break
            }
        }
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
