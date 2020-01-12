//
//  Currency.swift
//  KursyWalutNBP
//
//  Created by xxx on 12/01/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

import Foundation

//
// MARK: - Currency
//
class Currency {
    
    //
    // MARK: - Variables and Properties
    //
    var tableName: String
    //var efectiveDate: Date
    var currencyName: String
    var currencyCode: String
    var averageCurrencyRate: Double
    
//    var dateString: String {
//      return Constants.DateFormatters.simpleDateFormatter.string(from: efectiveDate)
//    }
    
    //
    // MARK: - Initialization
    //
    init(tableName: String, currencyName: String, currencyCode: String, averageCurrencyRate: Double) {
      self.tableName = tableName
      self.currencyName = currencyName
      self.currencyCode = currencyCode
      self.averageCurrencyRate = averageCurrencyRate
      //self.efectiveDate = efectiveDate
    }
}




