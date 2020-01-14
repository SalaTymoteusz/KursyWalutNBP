//
//  CurrencyListViewController.swift
//  KursyWalutNBP
//
//  Created by xxx on 12/01/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//
// MARK: - Currency List View Controller
//
class CurrencyListBViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //
        // MARK: - Custom Navigation Bar
        //
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        //
        // MARK: - Custom Tab Bar
        //
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // first load data
        fetchCurrenyData()
        
        //
        // MARK: - Refresh Table View
        //
        tableView.refreshControl = refresher
    }
    
    //
    // MARK: - Variables And Properties
    //
    var currencies: [Currency] = []
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
    }()
 
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
    
    //
    // MARK: - Actions
    //
    @IBAction func tappedRefreshButton(_ sender: Any) {
        //fetchCurrenyData()
    }
    
    
    //
    // MARK: - available to Objective-C
    //
    @objc func refresh() {
        fetchCurrenyData()
        
        let deadline = DispatchTime.now() + .milliseconds(700)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.refresher.endRefreshing()
        }
    }
    
    
    //
    // MARK: - Fetch JSON Data
    //
    func fetchCurrenyData() {
        DispatchQueue.main.async {
            let apiUrl = "http://api.nbp.pl/api/exchangerates/tables/b/"
            Alamofire.request(apiUrl, method: .get).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    
                    self.currencies.removeAll()

                    let json = JSON(value)
                    let data = json[0]
                    print(data)
                    let effectiveDateString = json[0, "effectiveDate"].stringValue
                    data["rates"].array?.forEach({(currency) in
                        let currency = Currency(tableName: "A", currencyName: currency["currency"].stringValue, currencyCode: currency["code"].stringValue, averageCurrencyRate: currency["mid"].doubleValue, effectiveDate: effectiveDateString)
                        self.currencies.append(currency)
                    })
                    self.tableView.reloadData()
                    print("table reloaded")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
      //
      // MARK: - Pass Data to Detail View Controller
      //
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          super.prepare(for: segue, sender: sender)
    
          if
              segue.identifier == "ShowDetails",
              let detailViewController = segue.destination as? DetailViewController,
              let currencyCell = sender as? UITableViewCell,
              let row = tableView.indexPath(for: currencyCell)?.row
          {
            detailViewController.name = currencies[row].currencyName
                  detailViewController.code = currencies[row].currencyCode
          }
      }
}

//
// MARK: - Table View Data Source
//
extension CurrencyListBViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = self.currencies[indexPath.row]
        let currencyCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        currencyCell.currencyCodeLabel.text = currency.currencyCode
        currencyCell.averageCurrencyRateValueLabel.text = "\(currency.averageCurrencyRate)"
        currencyCell.currencyNameLabel.text = currency.currencyName
        currencyCell.effectiveDateLabel.text = currency.effectiveDate
        
        return currencyCell
    }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.currencies.count
  }
}

//
// MARK: - Table View Delegate
//
extension CurrencyListBViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}



