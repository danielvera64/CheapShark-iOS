//
//  AppError.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation

public enum AppError: Error {
   case custom(description: String?)
   case unknown
}

public extension AppError {
   var errorDescription: String {
      switch self {
      case .custom(let description): return description ?? "general_error".localized
      default: return "general_error".localized
      }
   }
}
