//
//  ViewController2.swift
//  CoinBase
//
//  Created by Iman Azher on 29/11/2024.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var portfolioBalanceLabel: UILabel!
    @IBOutlet weak var portfolioBalance: UILabel!
    
    // MARK: - Variables
    var sampleData = [
        PortfolioItem(
            iconName: "ic-test",
            itemName: "USD Coin",
            itemValue: "$12.3",
            detail: "0 USDC"
        ),
        PortfolioItem(
            iconName: "MATIC - Matic Token",
            itemName: "Polygon",
            itemValue: "$13.80",
            detail: "8.52889997 MATIC"
        ),
        PortfolioItem(
            iconName: "ic-ox",
            itemName: "Ox",
            itemValue: "$0",
            detail: "0 ZRX"
        ),
        PortfolioItem(
            iconName: "1INCH - 1INCH Token",
            itemName: "1Inch",
            itemValue: "$0",
            detail: "0 1INC"
        ),
        PortfolioItem(
            iconName: "aAAVE - Aave AAVE",
            itemName: "Aave",
            itemValue: "$0",
            detail: "0 AAVE"
        ),
        PortfolioItem(
            iconName: "ALGO - Algorand",
            itemName: "Algorand",
            itemValue: "$0",
            detail: "0 ALGO"
        ),
        PortfolioItem(
            iconName: "ic-ox",
            itemName: "Ox",
            itemValue: "$20",
            detail: "0 ZRX"
        ),
        PortfolioItem(
            iconName: "1INCH - 1INCH Token",
            itemName: "1Inch",
            itemValue: "$0",
            detail: "0 1INC"
        ),
        PortfolioItem(
            iconName: "ALGO - Algorand",
            itemName: "Algorand",
            itemValue: "$10",
            detail: "0 ALGO"
        ),
        PortfolioItem(
            iconName: "ALGO - Algorand",
            itemName: "Algorand",
            itemValue: "$0",
            detail: "0 ALGO"
        ),
        PortfolioItem(
            iconName: "MATIC - Matic Token",
            itemName: "Polygon",
            itemValue: "$0",
            detail: "8.52889997 MATIC"
        ),
        PortfolioItem(
            iconName: "ic-test",
            itemName: "USD Coin",
            itemValue: "$5.00",
            detail: "0 USDC"
        ),
        PortfolioItem(
            iconName: "ic-test",
            itemName: "USD Coin",
            itemValue: "$0.00",
            detail: "0 USDC"
        )
    ]

    // MARK: - Helper Functions
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        portfolioBalanceSetup()
    }
    
    func portfolioBalanceSetup() {
        portfolioBalanceLabel.textColor = UIColor(red: 112/235, green: 112/235, blue: 112/235, alpha: 100)
        calculatePortfolioBalance()
    }
    
    func calculatePortfolioBalance() {
        var totalBalance: Double = 0.0
        for item in sampleData {
            let valueStr = item.itemValue.replacingOccurrences(of: "$", with: "")
            guard let valueNumeric = Double(valueStr) else {
                return
            }
            totalBalance += valueNumeric
        }
        let totalBalanceStr = String(format: "%.2f", totalBalance)
        portfolioBalance.text = totalBalanceStr
    }
    
    // MARK: - Data source functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else {
            return CustomCell()
        }
        let currSampleData = sampleData[indexPath.row]
        cell.updateCells(model: currSampleData)
        cell.layoutIfNeeded()
        return cell
    }
}
