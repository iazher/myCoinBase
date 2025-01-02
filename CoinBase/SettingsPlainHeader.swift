//
//  SettingsPlainHeader.swift
//  CoinBase
//
//  Created by Iman Azher on 01/01/2025.
//

import UIKit

class SettingsPlainHeader: UITableViewHeaderFooterView {

    //MARK: - IB Outlets
    @IBOutlet weak var headerLabel: UILabel!
    
    //MARK: - Helper Functions
    func setLabel(label: String) {
        headerLabel.text = label
    }
}
