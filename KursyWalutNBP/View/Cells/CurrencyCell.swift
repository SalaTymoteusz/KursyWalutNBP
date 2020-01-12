//
//  CurrencyCell.swift
//  KursyWalutNBP
//
//  Created by xxx on 12/01/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

import UIKit

//
// MARK: - Currency Cell
//
class CurrencyCell: UITableViewCell {
    
    //
    // MARK: - Class Constants
    //
    static let identifier = "CurrencyCell"
    
    //
    // MARK: - Outlets
    //
    
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var averageCurrencyRateValueLabel: UILabel!
    
    //
    // MARK: - Table View Cell
    //
    override func prepareForReuse() {
      super.prepareForReuse()
      
      currencyCodeLabel.text = nil
      currencyNameLabel.text = nil
      averageCurrencyRateValueLabel.text = nil
    }
}
