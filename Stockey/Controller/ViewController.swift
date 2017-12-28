//
//  ViewController.swift
//  Stockey
//
//  Created by Vandan Patel on 12/25/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let stockSymbols = ["AAPL", "GOOGL", "MSFT","FB","INTC","ORCL","CSCO","IBM","SAP"]
    var stocks = [Stock]()
    let stockDispatchGroup = DispatchGroup()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        loadData()
    }
    
    func loadData() {
        //these are asynchronus calls, first call doesn't necessarily returns first, so there is a field stock name in the model to store the name of the stock and values as they return. stockSybols array could be used if they are synchronus calls [Note: I try to write as less comments as possible in my code, but since this is a sample code, I thought I might be easier to understand the logic with comments :)]
        refreshButton.isEnabled = false
        self.showActivityIndicator()
        for symbol in stockSymbols {
            stockDispatchGroup.enter()
            DataService.shared.getStockData(for: symbol, completion: { [weak self] (dict) in
                let stockData = StockData(dict: dict!)
                if let value = stockData.topLevelData.first?.value {
                    let stock = Stock(dict: value, metaData: stockData.metaData)
                    self?.stocks.append(stock)
                    let indexPath = IndexPath(row: ((self?.stocks.count)! - 1), section: 0)
                    DispatchQueue.main.async { self?.tableView.insertRows(at: [indexPath], with: .automatic) }
                }
                self?.stockDispatchGroup.leave()
            })
        }
        stockDispatchGroup.notify(queue: .main) {
            self.hideActivityIndicator()
            self.refreshButton.isEnabled = true
        }
    }
    
    @IBAction func didTapRefresh(_ sender: UIBarButtonItem) {
        stocks.removeAll()
        tableView.reloadData()
        loadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = stocks[indexPath.row]
        cell.textLabel?.text = stock.name
        cell.detailTextLabel?.text = stock.close
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stock = stocks[indexPath.row]
        self.performSegue(withIdentifier: "toStockDetail", sender: stock)
        tableView.deselectRow(at: indexPath, animated: true) //gives nice animation to cell selection
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStockDetail" {
            let destVC = segue.destination as! StockDetailViewController // forced-unwrapping on purpose
            let stock = sender as! Stock
            destVC.stock = stock
        }
    }
}




