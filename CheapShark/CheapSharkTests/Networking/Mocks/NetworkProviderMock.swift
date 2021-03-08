//
//  NetworkProviderMock.swift
//  CheapSharkTests
//
//  Created by Daniel Vera on 3/2/21.
//

import Foundation

@testable import CheapShark

class NetworkProviderMock<Target: AppTargetType>: NetworkProvider<Target> {

  private let mockDecoder: JSONDecoder = JSONDecoder()

  override func perform<T: Codable>(
    _ target: Target,
    completionHandler: @escaping (Result<T, AppError>) -> Void
  ) {
    if let storeProvider = target as? StoreManagerProvider {
      mockStoreService(provider: storeProvider, completionHandler: completionHandler)
    }
  }

  private func mockStoreService<T: Codable>(
    provider: StoreManagerProvider,
    completionHandler: @escaping (Result<T, AppError>) -> Void
  ) {
    switch provider {
    case .getStores:
      let value = try! self.mockDecoder.decode(T.self, from: getDataOf(fileName: "getStores"))
      completionHandler(.success(value))
      break
    }
  }

  private func getDataOf(fileName: String) -> Data {
     return try! Data(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "json")!)
  }

}
