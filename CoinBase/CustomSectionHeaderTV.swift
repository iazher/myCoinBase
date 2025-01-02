//
//  CustomSectionHeaderTV.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

import UIKit

class CustomSectionHeaderTV: UITableViewHeaderFooterView {
    
    //MARK: - IB Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerLabelRight: UILabel! {
        didSet {
            headerLabelRight.text = ""
        }
    }
}
