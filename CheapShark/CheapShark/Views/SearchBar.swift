//
//  SearchBar.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import Foundation
import SwiftUI

struct SearchBar: View {
   
   @Binding var text: String
   
   @State private var isEditing = false
   
   var body: some View {
      HStack {
         
         TextField("search_title".localized, text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .keyboardType(.webSearch)
            .overlay(
               HStack {
                  Image(systemName: "magnifyingglass")
                     .foregroundColor(.gray)
                     .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                     .padding(.leading, 8)
                  
                  if isEditing {
                     Button(action: {
                        self.text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                     }) {
                        Image(systemName: "multiply.circle.fill")
                           .foregroundColor(.gray)
                           .padding(.trailing, 8)
                     }
                  }
               }
            )
            .padding(.horizontal, 10)
            .onTapGesture {
               self.isEditing = true
            }
         
         if isEditing {
            Button(action: {
               self.isEditing = false
               self.text = ""
               UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
               Text("cancel_title".localized)
            }
            .padding(.trailing, 10)
            .transition(.move(edge: .trailing))
            .animation(.default)
         }
      }
      .background(Color.clear)
   }
}

struct SearchBar_Previews: PreviewProvider {
   static var previews: some View {
      SearchBar(text: .constant(""))
   }
}
