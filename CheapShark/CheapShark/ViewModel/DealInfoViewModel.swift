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

  private lazy var dealService: DealService = resolver.resolve()

  private var cancellable = Set<AnyCancellable>()

  private let metacriticBaseUrl = "https://www.metacritic.com/"

  func getDealInfo(id: String) {
    isLoading = true
    dealService.getDealBy(id: id, completion: { [weak self] result in
      self?.isLoading = false
      switch result {
      case .success(let info):
        self?.dealInfo = info
      case .failure(let error):
        print(error)
      }
    })
  }

  func getMetacriticLink() -> URL {
    guard let path = dealInfo?.gameInfo?.metacriticLink else {
      return URL(string: metacriticBaseUrl)!
    }
    return URL(string: metacriticBaseUrl + path)!
  }

}
