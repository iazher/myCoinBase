//
//  CustomHeaderSettingsScreen.swift
//  CoinBase
//
//  Created by Iman Azher on 01/01/2025.
//

import UIKit

class SettingsPromoCustomHeader: UITableViewHeaderFooterView {
    
    //MARK: - IB Outlets
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    //MARK: - Helper Functions
    func setUserName(name: String) {
        userName.text = name
    }
    
    func setUserEmail(email: String) {
        userEmail.text = email
    }
}
