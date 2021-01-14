//
//  LoadingView.swift
//  CheapShark
//
//  Created by Daniel Vera on 14/1/21.
//

import SwiftUI

struct LoadingView: View {
   
   var backgroundColor: Color
   
   var body: some View {
      HStack {
         Spacer()
         Text("loading_title".localized)
         Spacer()
      }
      .padding(.all, 5)
      .background(backgroundColor)
   }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
      LoadingView(backgroundColor: Color.clear)
    }
}
