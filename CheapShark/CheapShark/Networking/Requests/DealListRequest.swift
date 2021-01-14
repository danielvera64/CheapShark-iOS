//
//  DealListRequest.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import Foundation

struct DealListRequest {
   var pageNumber: Int
   var pageSize: Int
   var sortBy: SortType
   var title: String?
   
   init(pageNumber: Int, pageSize: Int = 15, sortBy: SortType = .recent, title: String? = nil) {
      self.pageNumber = pageNumber
      self.pageSize = pageSize
      self.sortBy = sortBy
      self.title = title
   }
   
   func getUQueryItems() -> [URLQueryItem] {
      var items = [URLQueryItem]()
      items.append(URLQueryItem(name: "pageNumber", value: "\(pageNumber)"))
      items.append(URLQueryItem(name: "pageSize", value: "\(pageSize)"))
      items.append(URLQueryItem(name: "sortBy", value: sortBy.rawValue))
      if let titleStr = title, !titleStr.isEmpty {
         items.append(URLQueryItem(name: "title", value: titleStr))
      }
      return items
   }
}

enum SortType: String, CaseIterable {
   case Title
   case Savings
   case Price
   case Release
   case Store
   case recent
}
