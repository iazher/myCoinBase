//
//  WelcomeTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 24/12/2024.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {

    @IBOutlet weak var addPaymentBtn: UIButton! {
        didSet {
            addPaymentBtn.layer.cornerRadius = 8
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
