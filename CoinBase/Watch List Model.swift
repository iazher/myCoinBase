//
//  Watch List Model.swift
//  CoinBase
//
//  Created by Iman Azher on 31/12/2024.
//

import Foundation

class WatchListModel {
    var title: String
    var abbreviation: String
    var iconName: String
    var amount: String
    var increase: String
    
    init(title: String, abbreviation: String, iconName: String, amount: String, increase: String) {
        self.title = title
        self.abbreviation = abbreviation
        self.iconName = iconName
        self.amount = amount
        self.increase = increase
    }
}
