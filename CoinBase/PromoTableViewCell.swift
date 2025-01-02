//
//  PromoTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 01/01/2025.
//

import UIKit

class PromoTableViewCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var promoText: UILabel!
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorders()
        promoText.text = "Share your love of crypto and get $10 of free Bitcoin"
        icon.image = UIImage(named: "BTC - Bitcoin")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Helper Functions
    func setBorders() {
        self.layer.borderColor = UIColor(named: "Border custom gray")?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
}
