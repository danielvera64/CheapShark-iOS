//
//  Resolver+Extension.swift
//  CheapShark
//
//  Created by Daniel Vera on 14/1/21.
//

import Resolver

extension Resolver: ResolverRegistering {
   
   public static func registerAllServices() {
      register { MainTabView() }
      register { DealsListView() }
      register { _, args in LoadingView(backgroundColor: args()) }
      register { _, args in DetailView(dealInfo: args("dealInfo"), store: args("store"), metacriticUrl: args("metacriticUrl"))}
      
      register { DealsListViewModel() }
      register { DealInfoViewModel() }
      
      register { AppService() }
   }
   
}
