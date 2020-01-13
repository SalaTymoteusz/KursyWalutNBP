//
//  DetailViewController.swift
//  KursyWalutNBP
//
//  Created by xxx on 13/01/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyNameLabel.text = name

        // Do any additional setup after loading the view.
    }
    
    var name: String = ""
    
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
