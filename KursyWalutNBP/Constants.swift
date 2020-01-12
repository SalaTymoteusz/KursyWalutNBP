//
//  Constants.swift
//  KursyWalutNBP
//
//  Created by xxx on 12/01/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

import Foundation

//
// MARK: - Constants
//
struct Constants {
  //
  // MARK: - Date Formatters
  //
  struct DateFormatters {
    static let simpleDateFormatter: DateFormatter = {
      var dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MM/dd/yyyy"
      return dateFormatter
    }()
  }
}
