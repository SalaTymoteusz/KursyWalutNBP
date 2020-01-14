//
//  DetailViewController.swift
//  KursyWalutNBP
//
//  Created by xxx on 12/01/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Charts

//
// MARK: - Currency List View Controller
//
class DetailViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //
        // MARK: - Custom Navigation Controller look
        //
        
        // Custom Navigation Bar
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // Custom Tab Bar
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // first load data
        fetchCurrenyData()
        
        
        // Refresh Table View
        tableView.refreshControl = refresher
        
        startDatePicker = UIDatePicker()
        startDatePicker?.datePickerMode = .date
        startDateTextField.inputView = startDatePicker
        
        endDatePicker = UIDatePicker()
        endDatePicker?.datePickerMode = .date
        endDateTextField.inputView = endDatePicker
        
        
    }
    
    //
    // MARK: - Variables And Properties
    //
    var currencies: [Currency] = []
    var chartData : [ChartDataEntry] = []
    var name: String = ""
    var code: String = ""
    var tableName: String = ""
    var i = 0
    var startDatePicker: UIDatePicker?
    var endDatePicker: UIDatePicker?
    
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
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
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
    
    
    // Present chart
    func setChartView(chartData: [ChartDataEntry]) {
        let dataSet = LineChartDataSet(values:chartData,label:code)
        let data = LineChartData(dataSet:dataSet)
        self.lineChartView.data = data
           
        // Chart appearance
        lineChartView.data?.setValueTextColor(NSUIColor.white)
        lineChartView.data?.setValueFont(NSUIFont.systemFont(ofSize: 0))
        lineChartView.xAxis.labelTextColor = UIColor.white
        lineChartView.leftAxis.labelTextColor = UIColor.white
        lineChartView.rightAxis.labelTextColor = UIColor.white
        lineChartView.legend.textColor = UIColor.white
        }
    
    
    //
    // MARK: - Fetch JSON Data
    //
    func fetchCurrenyData(){
    DispatchQueue.main.async {
        let apiUrl = "http://api.nbp.pl/api/exchangerates/rates/\(self.tableName)/\(self.code)/2019-12-01/2019-12-20/"
        Alamofire.request(apiUrl, method: .get).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                
                // Clear data
                self.currencies.removeAll()
                self.chartData.removeAll()
                
                self.i = 0
                
                // Parse json data
                let data = JSON(value)
                data["rates"].array?.forEach({(currency) in
                    // Creating Currency object
                    let currency = Currency(tableName: self.tableName, currencyName: self.name, currencyCode: self.code, averageCurrencyRate: currency["mid"].doubleValue, effectiveDate: currency["effectiveDate"].stringValue)
                    self.currencies.append(currency)
                    
                    //
                    // MARK: - Set values for Chart
                    //
                    
                    // Set value to chart point
                    let point = ChartDataEntry(x: Double(self.i), y: currency.averageCurrencyRate)
                    self.chartData.append(point)
                    self.i = self.i + 1
                    })
                    // Present chart
                    self.setChartView(chartData: self.chartData)
                    
                    // Reload table view data
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



