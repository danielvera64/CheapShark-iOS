//
//  CheapSharkApp.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import SwiftUI
import Resolver

@main
struct CheapSharkApp: App {
   var body: some Scene {
      WindowGroup {
         Resolver.resolve() as MainTabView
      }
   }
}
