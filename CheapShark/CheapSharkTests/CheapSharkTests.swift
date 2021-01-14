//
//  CheapSharkTests.swift
//  CheapSharkTests
//
//  Created by Daniel Vera on 13/1/21.
//

import XCTest
import Resolver
import Combine

@testable import CheapShark

class CheapSharkTests: XCTestCase, Resolving {
   
   private lazy var service: AppService = resolver.resolve()
   
   private var cancellable = Set<AnyCancellable>()
   
   override func setUpWithError() throws {
      // Put setup code here. This method is called before the invocation of each test method in the class.
      Resolver.registerTestServices()
   }
   
   override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
   }
   
   func testExample() throws {
      let requestExpectation = expectation(description: "Request should finish")
      
      service.getStores()
         .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
               break
            case .failure(let error):
               XCTFail(error.localizedDescription)
            }
         }, receiveValue: { result in
            defer { requestExpectation.fulfill() }
            XCTAssertEqual(result.count, 1)
            XCTAssertEqual(result.first?.storeName, "TEST")
         }).store(in: &cancellable)
      
      wait(for: [requestExpectation], timeout: 10.0)
   }
   
}
