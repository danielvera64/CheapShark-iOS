//
//  StoreTests.swift
//  CheapSharkTests
//
//  Created by Daniel Vera on 3/2/21.
//

import XCTest
import Resolver
import Combine

@testable import CheapShark

class StoreTests: XCTestCase, Resolving {

  private lazy var service: StoreService = resolver.resolve()

  override func setUpWithError() throws {
    Resolver.registerTestServices()
  }

  func testGettingStores() throws {
    let requestExpectation = expectation(description: "Request should finish")
    service.getStores(completion: { result in
      switch result {
      case .success(let stores):
        defer { requestExpectation.fulfill() }
        XCTAssertEqual(stores.count, 2)
        XCTAssertEqual(stores.first?.storeName, "Steam")
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    })
    wait(for: [requestExpectation], timeout: 2.0)
  }

}
