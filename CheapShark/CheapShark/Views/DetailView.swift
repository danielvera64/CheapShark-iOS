//
//  DetailView.swift
//  CheapShark
//
//  Created by Daniel Vera on 14/1/21.
//

import SwiftUI

struct DetailView: View {
   
   @State var dealInfo: DealLookup
   @State var store: String
   @State var metacriticUrl: URL
   
   var body: some View {
      HStack {
         VStack(alignment: .leading, spacing: 0) {
            Text(dealInfo.gameInfo?.name ?? "")
               .font(.title)
               .padding(.bottom, 20)
            
            HStack {
               Text("sale_price".localized)
                  .font(.title2)
               
               Text("$\(dealInfo.gameInfo?.salePrice ?? "0")")
                  .font(.title2)
            }
            
            HStack {
               Text("normal_price".localized)
               
               Text("$\(dealInfo.gameInfo?.retailPrice ?? "0")")
            }
            .padding(.bottom, 10)
            
            HStack {
               Text("rating_title".localized)
                  .font(.title2)
               
               Text("\(dealInfo.gameInfo?.steamRatingPercent ?? "0")%")
                  .font(.title2)
            }
            
            HStack {
               Text(store.isEmpty ? "" : "store_title".localized)
               
               Text(store)
            }
            .padding(.bottom, 10)
            
            Link("metacritic_title".localized, destination: metacriticUrl)
            
            Spacer()
         }
         Spacer()
      }
   }
}
