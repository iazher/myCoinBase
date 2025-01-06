//
//  ButtonTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 01/01/2025.
//

import UIKit

class PaymentButtonTVCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var actionBtn: UIButton! {
        didSet {
            actionBtn.layer.cornerRadius = 8
            actionBtn.layer.borderWidth = 1
            actionBtn.layer.borderColor = UIColor(named: "Custom border gray")?.cgColor
            actionBtn.layer.masksToBounds = true
        }
    }
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
