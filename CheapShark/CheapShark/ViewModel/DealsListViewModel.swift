//
//  DealsListViewModel.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import Foundation
import Combine
import Resolver

class DealsListViewModel: ObservableObject, Resolving {

  @Published var searchText = ""
  @Published var dealList = [Deal]()
  @Published var isLoading = false
  @Published var sorting: SortType = .recent

  private var storeList = [Store]()

  private var pageSubject = CurrentValueSubject<Int, Never>(0)
  
  private lazy var storeService: StoreService = resolver.resolve()
  private lazy var dealService: DealService = resolver.resolve()

  private var cancellable = Set<AnyCancellable>()

  init() {
    getStores()

    $searchText
      .dropFirst()
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .sink(receiveValue: { [weak self] _ in
        self?.pageSubject.send(0)
        self?.dealList = []
      })
      .store(in: &cancellable)

    $sorting
      .dropFirst()
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .sink(receiveValue: { [weak self] _ in
        self?.pageSubject.send(0)
        self?.dealList = []
      })
      .store(in: &cancellable)
  }

  func loadMoreContentIfNeeded(current: Deal) {
    guard !isLoading, dealList.last?.dealID == current.dealID else {
      return
    }
    pageSubject.send(pageSubject.value + 1)
  }

  func getStoreName(current: Deal) -> String {
    return storeList.first(where: { $0.storeID == current.storeID })?.storeName ?? ""
  }

  private func bindPageNumber() {
    pageSubject
      .debounce(for: 0.3, scheduler: RunLoop.main)
      .sink(receiveValue: { [weak self] page in
        let request = DealListRequest(pageNumber: page, sortBy: self?.sorting ?? .recent, title: self?.searchText)
        self?.getDeals(request: request)
      })
      .store(in: &cancellable)
  }

  private func getDeals(request: DealListRequest) {
    isLoading = true
    dealService.getDeals(request: request, completion: { [weak self] result in
      self?.isLoading = false
      switch result {
      case .success(let deals):
        self?.dealList.append(contentsOf: deals)
      case .failure(let error):
        print(error)
      }
    })
  }

  private func getStores() {
    isLoading = true
    storeService.getStores(completion: { [weak self] result in
      self?.isLoading = false
      self?.bindPageNumber()
      switch result {
      case .success(let stores):
        self?.storeList = stores
      case .failure(let error):
        print(error)
      }
    })
  }
  
}
