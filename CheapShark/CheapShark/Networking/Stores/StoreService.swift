//
//  StoreService.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation

public class StoreService {

  private let provider: NetworkProvider<StoreManagerProvider>

  init(provider: NetworkProvider<StoreManagerProvider> = NetworkProvider<StoreManagerProvider>()) {
    self.provider = provider
  }

  public func getStores(completion: @escaping (Result<[Store], AppError>) -> Void) {
    provider.perform(.getStores, completionHandler: { result in
      DispatchQueue.main.async {
        completion(result)
      }
    })
  }
  
}
