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
    
 //
 // MARK: - Variables And Properties
 //
 var currencyArray: CurrencyArray? {
     didSet {
     if isViewLoaded {
         tableView.reloadData()
     }
   }
 }
    
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
    let currencyCell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as! CurrencyCell
    
    if let currency = currencyArray?.currencies[indexPath.row] {
        currencyCell.currencyCodeLabel.text = currency.currencyCode
        currencyCell.averageCurrencyRateValueLabel.text = "\(currency.averageCurrencyRate)"
        currencyCell.currencyNameLabel.text = currency.currencyName
    }

    return currencyCell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencyArray?.currencies.count ?? 0
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
