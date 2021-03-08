//
//  DealManagerProvider.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation

public enum DealManagerProvider {
  case getDeals(request: DealListRequest)
  case getDealInfo(id: String)
}

extension DealManagerProvider: AppTargetType {

  public var baseURL: URL {
    return URL(string: "https://www.cheapshark.com/api/1.0/")!
  }
  
  public var path: String {
    switch self {
    case .getDeals, .getDealInfo:
      return "deals"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .getDeals, .getDealInfo:
      return .get
    }
  }
  
  public var headers: [String : String]? {
    switch self {
    case .getDeals, .getDealInfo:
      return ["Content-Type": "application/json"]
    }
  }

  public var parameters: [URLQueryItem] {
    switch self {
    case .getDeals(let request):
      return request.queryItems()
    case .getDealInfo:
      return []
    }
  }

  public var percentEncodedQuery: String {
    switch self {
    case .getDeals:
      return ""
    case .getDealInfo(let id):
      return "id=\(id)"
    }
  }

  public var data: Data? {
    switch self {
    case .getDeals, .getDealInfo:
      return nil
    }
  }
  
}
