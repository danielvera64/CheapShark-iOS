//
//  DealInfoView.swift
//  CheapShark
//
//  Created by Daniel Vera on 14/1/21.
//

import SwiftUI
import Resolver

struct DealInfoView: View, Resolving {
   
   @ObservedObject var viewModel: DealInfoViewModel = Resolver.resolve()
   
   @State var dealId: String
   @State var store: String
   
   var body: some View {
      ZStack {
         
         if let info = viewModel.dealInfo {
            resolver.resolve(DetailView.self, args: ["dealInfo": info,
                                                     "store": store,
                                                     "metacriticUrl": viewModel.getMetacriticLink()])
         }
         
         if viewModel.isLoading {
            Resolver.resolve(LoadingView.self, args: Color.clear)
         }
      }
      .padding()
      .onAppear {
         viewModel.getDealInfo(id: dealId)
      }
      .navigationBarTitle("", displayMode: .inline)
   }
}

struct DealInfoView_Previews: PreviewProvider {
   static var previews: some View {
      DealInfoView(dealId: "WibJnc8ITuQHJMn9hmm68fAnbKs%2Fo9amfQsBLFCWbf4%3D", store: "Steam")
   }
}
