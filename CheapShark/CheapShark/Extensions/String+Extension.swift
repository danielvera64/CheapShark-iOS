//
//  String+Extension.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import Foundation

extension String {
   
   var localized: String {
      return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: "", comment: "")
   }
   
}
