//
//  StockDetailViewController.swift
//  Stockey
//
//  Created by Vandan Patel on 12/26/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stock: Stock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        guard let stock = stock else { print("Failure in passing stock from main to detail"); return }
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = stock.name
    }
}

extension StockDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockDetailCell", for: indexPath)
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Open : "
            cell.detailTextLabel?.text = stock?.open
            return cell
        case 1:
            cell.textLabel?.text = "High : "
            cell.detailTextLabel?.text = stock?.high
            return cell
        case 2:
            cell.textLabel?.text = "Low : "
            cell.detailTextLabel?.text = stock?.low
            return cell
        case 3:
            cell.textLabel?.text = "Close : "
            cell.detailTextLabel?.text = stock?.close
            return cell
        case 4:
            cell.textLabel?.text = "Volume : "
            cell.detailTextLabel?.text = stock?.volume
            return cell
        case 5:
            cell.textLabel?.text = "Last Refreshed : "
            cell.textLabel?.textColor = UIColor.darkGray
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            cell.detailTextLabel?.text = stock?.lastRefreshed
            cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            cell.detailTextLabel?.textColor = UIColor.black
            return cell
        case 6:
            cell.textLabel?.text = "Time Zone : "
            cell.textLabel?.textColor = UIColor.darkGray
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            cell.detailTextLabel?.text = stock?.timeZone
            cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            cell.detailTextLabel?.textColor = UIColor.black
            return cell
        default:
            return cell
        }
    }
}
