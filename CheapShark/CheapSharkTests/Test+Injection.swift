//
//  Test+Injection.swift
//  CheapSharkTests
//
//  Created by Daniel Vera on 14/1/21.
//

import Foundation
import Resolver

@testable import CheapShark

extension Resolver {
   
   static let testing = Resolver(parent: main)
   
   static func registerTestServices() {
      root = testing
      register(AppService.self) { TestAppService() }
   }
}
