////
////  DetailViewController.swift
////  KursyWalutNBP
////
////  Created by xxx on 13/01/2020.
////  Copyright © 2020 xxx. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//import Charts
//
//class DetailViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        currencyNameLabel.text = name
//        print(code)
//
//        fetchCurrenyData(startDate: "2020-01-01", endDate: "2020-01-14")
//
//        setChartView()
//
//        // Do any additional setup after loading the view.
//    }
//
//    var name: String = ""
//    var code: String = ""
//    var currencies: [Currency] = []
//    var mid1: [Double] = []
//
//    @IBOutlet weak var currencyNameLabel: UILabel!
//    @IBOutlet weak var lineChartView: LineChartView!
//
//
//    func setChartView() {
////        let entry1 = ChartDataEntry(x:2.0,y:3.9047)
//
//        lineChartView.data?.setValueTextColor(NSUIColor.white)
//        lineChartView.data?.setValueFont(NSUIFont.systemFont(ofSize: 0))
//        lineChartView.xAxis.labelTextColor = UIColor.white
//        lineChartView.leftAxis.labelTextColor = UIColor.white
//        lineChartView.rightAxis.labelTextColor = UIColor.white
//        lineChartView.legend.textColor = UIColor.white
//
//
//
//    }
//
//
//    func fetchCurrenyData(startDate: String, endDate: String){
//        DispatchQueue.main.async {
//            let apiUrl = "http://api.nbp.pl/api/exchangerates/rates/A/USD/2019-12-01/2019-12-20/"
//            Alamofire.request(apiUrl, method: .get).responseJSON(completionHandler: { (response) in
//                switch response.result {
//                case .success(let value):
//
//                    let data = JSON(value)
//                    var i = 0
//                    data["rates"].array?.forEach({(currency) in
//                        let currency = Currency(tableName: "A", currencyName: self.name, currencyCode: self.code, averageCurrencyRate: currency["mid"].doubleValue, effectiveDate: currency["effectiveDate"].stringValue)
//                        self.currencies.append(currency)
//                        print(self.currencies.count)
//                        print(self.currencies[i].averageCurrencyRate)
//                        self.mid1.append(self.currencies[i].averageCurrencyRate)
//                        print(self.currencies[i].effectiveDate)
//                        i = i + 1
//                    })
//                    print(self.currencies.count)
//
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            })
//        }
//    }
//
//
//}
//
//  CurrencyListViewController.swift
//  KursyWalutNBP
//
//  Created by xxx on 12/01/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

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
class DetailViewController: UIViewController {
    
    

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
    var name: String = ""
    var code: String = ""
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
    }()
 
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
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
    func fetchCurrenyData(){
    DispatchQueue.main.async {
        let apiUrl = "http://api.nbp.pl/api/exchangerates/rates/A/USD/2019-12-01/2019-12-20/"
        Alamofire.request(apiUrl, method: .get).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):

                let data = JSON(value)
                data["rates"].array?.forEach({(currency) in
                    let currency = Currency(tableName: "A", currencyName: self.name, currencyCode: self.code, averageCurrencyRate: currency["mid"].doubleValue, effectiveDate: currency["effectiveDate"].stringValue)
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
}

//
// MARK: - Table View Data Source
//
extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = self.currencies[indexPath.row]
        let currencyCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        currencyCell.averageCurrencyRateValueLabel.text = "\(currency.averageCurrencyRate)"
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
extension DetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}



