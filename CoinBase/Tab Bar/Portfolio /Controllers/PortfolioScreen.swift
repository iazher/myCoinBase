//
//  ViewController2.swift
//  CoinBase
//
//  Created by Iman Azher on 29/11/2024.
//

import UIKit

class PortfolioScreen: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerTableCells()
            tableView.separatorStyle = .none
            tableView.sectionHeaderTopPadding = 0
            tableView.showsVerticalScrollIndicator = false
        }
    }
    @IBOutlet weak var portfolioBalanceLabel: UILabel!
    @IBOutlet weak var portfolioBalance: UILabel!
    
    // MARK: - Variables
    var sampleData = [
        PortfolioItem(
            iconName: "ic-test",
            itemName: "USD Coin",
            itemValue: "$0.00",
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
            itemValue: "$0.00",
            detail: "0 ZRX"
        ),
        PortfolioItem(
            iconName: "1INCH - 1INCH Token",
            itemName: "1Inch",
            itemValue: "$0.00",
            detail: "0 1INC"
        ),
        PortfolioItem(
            iconName: "aAAVE - Aave AAVE",
            itemName: "Aave",
            itemValue: "$0.00",
            detail: "0 AAVE"
        ),
        PortfolioItem(
            iconName: "ALGO - Algorand",
            itemName: "Algorand",
            itemValue: "$0.00",
            detail: "0 ALGO"
        ),
        PortfolioItem(
            iconName: "ampl",
            itemName: "Ampleforth Governance",
            itemValue: "$0.00",
            detail: "0 FORTH"
        ),
        PortfolioItem(
            iconName: "1INCH - 1INCH Token",
            itemName: "1Inch",
            itemValue: "$0.00",
            detail: "0 1INC"
        ),
        PortfolioItem(
            iconName: "ALGO - Algorand",
            itemName: "Algorand",
            itemValue: "$10.00",
            detail: "0 ALGO"
        ),
        PortfolioItem(
            iconName: "ALGO - Algorand",
            itemName: "Algorand",
            itemValue: "$0.00",
            detail: "0 ALGO"
        ),
        PortfolioItem(
            iconName: "MATIC - Matic Token",
            itemName: "Polygon",
            itemValue: "$0.00",
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
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
    }
    
    // MARK: - Helper Functions
    func registerTableCells() {
        //custom cells
        tableView.register(UINib(nibName: "PortfolioItemCell", bundle: nil), forCellReuseIdentifier: "PortfolioItemCell")
  
        //custom headers
        tableView.register(UINib(nibName: "PortfolioBalanceHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "PortfolioBalanceHeader")
    }
    
    func calculatePortfolioBalance() -> Double{
        var totalBalance: Double = 0.0
        for item in sampleData {
            let valueStr = item.itemValue.replacingOccurrences(of: "$", with: "")
            guard let valueNumeric = Double(valueStr) else {
                return 0
            }
            totalBalance += valueNumeric
        }
        return totalBalance
    }
    
    // navigates to next screen (displays cell information) based on the cell selected by user
    func navigateToScreen(_ identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
}

// MARK: - Table View Delegates
extension PortfolioScreen: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PortfolioBalanceHeader") as? PortfolioBalanceHeader else {
            return UIView()
        }
        header.setPortfolioBalance(balance: calculatePortfolioBalance())
        header.backgroundConfiguration?.backgroundColor = .systemBackground
        return header
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioItemCell") as? PortfolioItemCell else {
            return PortfolioItemCell()
        }
        let currSampleData = sampleData[indexPath.row]
        cell.updateCells(model: currSampleData)
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToScreen("TableViewNextScreen")
    }
}
