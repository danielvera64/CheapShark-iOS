//
//  Deal.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import Foundation

struct Deal: Codable {
   var title: String?
   var metacriticLink: String?
   var dealID: String?
   var storeID: String?
   var gameID: String?
   var salePrice: String?
   var normalPrice: String?
   var steamRatingPercent: String?
   var steamAppID: String?
   var releaseDate: Int?
   var lastChange: Int?
   var thumb: String?

   init(title: String?, metacriticLink: String? = nil, dealID: String? = nil, storeID: String? = nil, gameID: String? = nil, salePrice: String?,
        normalPrice: String?, steamRatingPercent: String?, steamAppID: String? = nil, releaseDate: Int? = nil, lastChange: Int? = nil, thumb: String? = nil)
   {
      self.title = title
      self.metacriticLink = metacriticLink
      self.dealID = dealID
      self.storeID = storeID
      self.gameID = gameID
      self.salePrice = salePrice
      self.normalPrice = normalPrice
      self.steamRatingPercent = steamRatingPercent
      self.steamAppID = steamAppID
      self.releaseDate = releaseDate
      self.lastChange = lastChange
      self.thumb = thumb
   }
   
}
