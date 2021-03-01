//
//  StoreManagerProvider.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation

public enum StoreManagerProvider {
  case getStores
}

extension StoreManagerProvider: AppTargetType {

  public var baseURL: URL {
    return URL(string: "https://www.cheapshark.com/api/1.0/")!
  }

  public var path: String {
    switch self {
    case .getStores:
      return "stores"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .getStores:
      return .get
    }
  }

  public var headers: [String : String]? {
    switch self {
    case .getStores:
      return  ["Content-Type": "application/json"]
    }
  }

  public var parameters: [URLQueryItem] {
    return []
  }

  public var percentEncodedQuery: String {
    return ""
  }
  
  public var data: Data? {
    switch self {
    case .getStores:
      return nil
    }
  }
  
}
