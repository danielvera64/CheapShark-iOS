//
//  ContentView.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import SwiftUI
import Resolver

struct MainTabView: View {
   
   var body: some View {
      TabView {
         
         NavigationView {
            Resolver.resolve() as DealsListView
         }
         .tabItem {
            Image(systemName: "dollarsign.circle.fill")
            Text("deals_title".localized)
         }
         
         Text("Hello, games!")
            .tabItem {
               Image(systemName: "gamecontroller.fill")
               Text("Games")
            }
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      MainTabView()
   }
}
