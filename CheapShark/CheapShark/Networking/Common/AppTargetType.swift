//
//  AppTargetType.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation

public protocol AppTargetType {

  var baseURL: URL { get }

  var path: String { get }

  var method: HTTPMethod { get }

  var headers: [String: String]? { get }

  var parameters: [URLQueryItem] { get }

  var percentEncodedQuery: String { get }
  
  var data: Data? { get }

}

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
}
