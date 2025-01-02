//
//  PortfolioItem.swift
//  CoinBase
//
//  Created by Iman Azher on 06/12/2024.
//

import Foundation

class PortfolioItem {
    
    var iconName: String    // image view
    var itemName: String    // e.g: USD Coin
    var itemValue: String  // e.g: $0
    var detail: String      // e.g: 0 USDC
    
    init(iconName: String, itemName: String, itemValue: String, detail: String) {
        self.iconName = iconName
        self.itemName = itemName
        self.itemValue = itemValue
        self.detail = detail
    }
}
