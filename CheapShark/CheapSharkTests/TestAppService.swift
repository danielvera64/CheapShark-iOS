//
//  TestAppService.swift
//  CheapSharkTests
//
//  Created by Daniel Vera on 14/1/21.
//

import Foundation
import Combine

@testable import CheapShark

class TestAppService: AppService {
   
   override func getStores() -> AnyPublisher<[Store], Error> {
      return Result
         .Publisher([Store(storeID: "999", storeName: "TEST", isActive: 1)])
         .eraseToAnyPublisher()
   }
   
}
