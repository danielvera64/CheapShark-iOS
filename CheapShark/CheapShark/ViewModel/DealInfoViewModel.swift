//
//  DealInfoViewModel.swift
//  CheapShark
//
//  Created by Daniel Vera on 14/1/21.
//

import Foundation
import Combine
import Resolver

class DealInfoViewModel: ObservableObject, Resolving {
   
   @Published var dealInfo: DealLookup?
   @Published var isLoading = false
   @Published var showMessage = false
   
   var errorMessage: String = ""
   
   private lazy var service: AppService = resolver.resolve()
   
   private var cancellable = Set<AnyCancellable>()
   
   private let metacriticBaseUrl = "https://www.metacritic.com/"
   
   func getDealInfo(id: String) {
      isLoading = true
      service.getDealInfo(dealId: id)
         .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            switch completion {
            case .finished:
               break
            case .failure(let error):
               self?.errorMessage = error.localizedDescription
               self?.showMessage = true
            }
         }, receiveValue: { [weak self] in
            self?.dealInfo = $0
         })
         .store(in: &cancellable)
   }
   
   func getMetacriticLink() -> URL {
      guard let path = dealInfo?.gameInfo?.metacriticLink else {
         return URL(string: metacriticBaseUrl)!
      }
      return URL(string: metacriticBaseUrl + path)!
   }
   
}
