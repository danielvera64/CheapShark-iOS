//
//  ParametersType.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation

public protocol ParametersType {
  func queryItems() -> [URLQueryItem]
}
