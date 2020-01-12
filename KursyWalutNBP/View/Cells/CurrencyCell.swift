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
    
    @IBOutlet weak var CurrencyCodeLabel: UILabel!
    @IBOutlet weak var CurrencyNameLabel: UILabel!
    @IBOutlet weak var AverageCurrencyRateValueLabel: UILabel!
    
    //
    // MARK: - Table View Cell
    //
    override func prepareForReuse() {
      super.prepareForReuse()
      
      CurrencyCodeLabel.text = nil
      CurrencyNameLabel.text = nil
      AverageCurrencyRateValueLabel.text = nil
    }
}
