//
//  DealsListView.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import Foundation
import SwiftUI

struct DealsListView: View {
   
   @ObservedObject var viewModel = DealsListViewModel()
   
   @State private var showingActionSheet = false
   
   var body: some View {
      VStack {
         
         SearchBar(text: $viewModel.searchText)
         
         ScrollView {
            LazyVStack {
               ForEach(viewModel.dealList, id: \.dealID) { deal in
                  let store = viewModel.getStoreName(current: deal)
                  NavigationLink(destination: DealInfoView(dealId: deal.dealID ?? "", store: store)) {
                     DealCellView(deal: deal, store: store)
                        .onAppear { viewModel.loadMoreContentIfNeeded(current: deal) }
                        .padding(.horizontal)
                  }
                  .buttonStyle(PlainButtonStyle())
               }
            }
         }
         if viewModel.isLoading {
            LoadingView(backgroundColor: .yellow)
         }
      }
      .navigationTitle("list_deals".localized)
      .navigationBarItems(trailing: Button(action: { showingActionSheet = true })
      {
         Text(viewModel.sorting.rawValue)
      })
      .actionSheet(isPresented: $showingActionSheet) {
         var buttons = [ActionSheet.Button]()
         for type in SortType.allCases {
            buttons.append(.default(Text(type.rawValue)) { viewModel.sorting = type } )
         }
         buttons.append(.cancel())
         return ActionSheet(title: Text("sort_deals_by".localized), message: nil, buttons: buttons)
      }
      
   }
   
}

struct DealsListView_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         DealsListView()
      }
   }
}
