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
   
   private lazy var service: AppService = resolver.resolve()
   
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
      service.getDeals(request: request)
         .first()
         .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            switch completion {
            case .finished:
               break
            case .failure(let error):
               print("DealsListViewModel Error: \(error)")
            }
         }, receiveValue: { [weak self] in
            self?.dealList.append(contentsOf: $0)
         })
         .store(in: &cancellable)
   }
   
   private func getStores() {
      isLoading = true
      service.getStores()
         .first()
         .sink(receiveCompletion: { [weak self] _ in
            self?.isLoading = false
            self?.bindPageNumber()
         }, receiveValue: { [weak self] in
            self?.storeList = $0
         })
         .store(in: &cancellable)
   }
}
