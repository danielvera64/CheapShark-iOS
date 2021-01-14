//
//  DealLookup.swift
//  CheapShark
//
//  Created by Daniel Vera on 14/1/21.
//

import Foundation

struct DealLookup: Codable {
   var gameInfo: DealGameInfo?
   var cheaperStores: [CheaperStore]?
   var cheapestPrice: CheapestPrice?
}

struct DealGameInfo: Codable {
   var storeID: String?
   var gameID: String?
   var name: String?
   var salePrice: String?
   var retailPrice: String?
   var steamRatingPercent: String?
   var metacriticLink: String?
   var releaseDate: Int?
   var thumb:  String?
}

struct CheapestPrice: Codable {
   var price: String?
   var date: Int?
}

struct CheaperStore: Codable {
   var dealID: String?
   var storeID: String?
   var salePrice: String?
   var retailPrice: String?
}
