//
//  PortfolioBalanceHeader.swift
//  CoinBase
//
//  Created by Iman Azher on 02/01/2025.
//

import UIKit

class PortfolioBalanceHeader: UITableViewHeaderFooterView {
    
    //MARK: - IB Outlets
    @IBOutlet weak var portfolioBalance: UILabel!
    
    //MARK: - Helper Functions
    func setPortfolioBalance(balance: Double) {
        let totalBalanceStr = String(format: "%.2f", balance)
        portfolioBalance.text = "$\(totalBalanceStr)"
    }

}
