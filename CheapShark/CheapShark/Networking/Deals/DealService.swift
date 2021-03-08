//
//  DealService.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation

public struct DealService {

  public var provider = NetworkProvider<DealManagerProvider>()

  public func getDeals(
    request: DealListRequest,
    completion: @escaping (Result<[Deal], AppError>) -> Void
  ) {
    provider.perform(.getDeals(request: request), completionHandler: { result in
      DispatchQueue.main.async {
        completion(result)
      }
    })
  }

  public func getDealBy(id: String, completion: @escaping (Result<DealLookup, AppError>) -> Void) {
    provider.perform(.getDealInfo(id: id), completionHandler: { result in
      DispatchQueue.main.async {
        completion(result)
      }
    })
  }

}
