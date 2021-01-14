//
//  DealCellView.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import Foundation
import SwiftUI

struct DealCellView: View {
   
   @State var deal: Deal
   @State var store: String
   
   var body: some View {
      VStack(alignment: .leading, spacing: 10) {
         
         Text((deal.title ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "no_title".localized : deal.title!)
            .font(.title2)
         
         HStack {
            
            VStack(alignment: .leading, spacing: 8) {
               HStack {
                  Text("sale_price".localized)
                  
                  Text("$\(deal.salePrice ?? "0")")
                     .font(.title2)
               }
               
               HStack {
                  Text("normal_price".localized)
                     .font(.subheadline)
                  
                  Text("$\(deal.normalPrice ?? "0")")
                     .font(.subheadline)
               }
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
               HStack {
                  Text("rating_title".localized)
                  
                  Text("\(deal.steamRatingPercent ?? "0")%")
                     .font(.title2)
               }
               HStack {
                  Text(store.isEmpty ? "" : "store_title".localized)
                     .font(.subheadline)
                  
                  Text(store)
                     .font(.subheadline)
               }
            }
            
         }
      }
      .padding(.vertical)
   }
}

struct DealCellView_Previews: PreviewProvider {
   static var previews: some View {
      DealCellView(deal: Deal(title: "TEST", salePrice: "9.99", normalPrice: "20.99", steamRatingPercent: "81"), store: "Steam")
         .previewLayout(.fixed(width: 500, height: 100))
   }
}
