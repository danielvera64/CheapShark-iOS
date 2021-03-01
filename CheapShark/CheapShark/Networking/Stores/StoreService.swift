//
//  StoreService.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation

public struct StoreService {

  public var provider = NetworkProvider<StoreManagerProvider>()

  public func getStores(completion: @escaping (Result<[Store], AppError>) -> Void) {
    provider.perform(.getStores, completionHandler: { result in
      DispatchQueue.main.async {
        completion(result)
      }
    })
  }
  
}
