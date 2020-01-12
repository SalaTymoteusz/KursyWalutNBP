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
    // MARK: - Variables
    //
    var tableName: String
    var efectiveDate: Date
    var currencyName: String
    var currencyCode: String
    var averageCurrencyRate: Double
    
    //
    // MARK: - Initialization
    //
    init(tableName: String, currencyName: String, currencyCode: String, averageCurrencyRate: Double, efectiveDate: Date) {
      self.tableName = tableName
      self.currencyName = currencyName
      self.currencyCode = currencyCode
      self.averageCurrencyRate = averageCurrencyRate
      self.efectiveDate = efectiveDate
    }
}




