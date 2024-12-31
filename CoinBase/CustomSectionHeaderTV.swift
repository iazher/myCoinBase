//
//  CustomSectionHeaderTV.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

import UIKit

class CustomSectionHeaderTV: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var headerLabelRight: UILabel! {
        didSet {
            headerLabelRight.text = ""
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
