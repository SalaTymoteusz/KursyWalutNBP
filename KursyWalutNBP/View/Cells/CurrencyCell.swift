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
    
    @IBOutlet weak var CurrencyCode: UILabel!
    @IBOutlet weak var CurrencyName: UILabel!
    @IBOutlet weak var AverageCurrencyValue: UILabel!
    
}
