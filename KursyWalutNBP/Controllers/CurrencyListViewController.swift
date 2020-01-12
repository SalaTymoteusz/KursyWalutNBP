//
//  CurrencyListViewController.swift
//  KursyWalutNBP
//
//  Created by xxx on 12/01/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

import UIKit

//
// MARK: - Currency List View Controller
//
class CurrencyListViewController: UIViewController {
    
    
    var currencies: [Currency] = [
        Currency(tableName: "A", currencyName: "Polski Złoty", currencyCode: "PL", averageCurrencyRate: 0.45633),
        Currency(tableName: "A", currencyName: "Amerykański Dolar", currencyCode: "USD", averageCurrencyRate: 1),
        Currency(tableName: "A", currencyName: "Czeska Korona", currencyCode: "CK", averageCurrencyRate: 0.556),
        Currency(tableName: "A", currencyName: "Euro", currencyCode: "EUR", averageCurrencyRate: 1.2633),
        Currency(tableName: "A", currencyName: "Amerykański Dolar", currencyCode: "USD", averageCurrencyRate: 1),
        Currency(tableName: "A", currencyName: "Czeska Korona", currencyCode: "CK", averageCurrencyRate: 0.556),
        Currency(tableName: "A", currencyName: "Euro", currencyCode: "EUR", averageCurrencyRate: 1.2633),
        Currency(tableName: "A", currencyName: "Amerykański Dolar", currencyCode: "USD", averageCurrencyRate: 1),
        Currency(tableName: "A", currencyName: "Czeska Korona", currencyCode: "CK", averageCurrencyRate: 0.556),
        Currency(tableName: "A", currencyName: "Euro", currencyCode: "EUR", averageCurrencyRate: 1.2633),
        Currency(tableName: "A", currencyName: "Amerykański Dolar", currencyCode: "USD", averageCurrencyRate: 1),
        Currency(tableName: "A", currencyName: "Czeska Korona", currencyCode: "CK", averageCurrencyRate: 0.556),
        Currency(tableName: "A", currencyName: "Euro", currencyCode: "EUR", averageCurrencyRate: 1.2633)]

 //
 // MARK: - Variables And Properties
 //
// var currencyArray: CurrencyArray? {
//     didSet {
//     if isViewLoaded {
//         tableView.reloadData()
//     }
//   }
// }
    
    
    
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
}

//
// MARK: - Table View Data Source
//
extension CurrencyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = currencies[indexPath.row]
        let currencyCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        currencyCell.currencyCodeLabel.text = currency.currencyCode
        currencyCell.averageCurrencyRateValueLabel.text = "\(currency.averageCurrencyRate)"
        currencyCell.currencyNameLabel.text = currency.currencyName
        
        return currencyCell
    }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencies.count
  }
}

//
// MARK: - Table View Delegate
//
extension CurrencyListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
