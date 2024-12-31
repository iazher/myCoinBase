//
//  TopMoversCollectionViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 25/12/2024.
//

import UIKit

class TopMoversCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var increase: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor(named: "Border custom gray")?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        // Initialization code
    }
    
    func setValues(model: TopMoversDataModel) {
        self.iconImage.image = UIImage(named: model.iconName)
        self.title.text = model.title
        self.amount.text = model.amount
        self.increase.text = model.increase
    }
}
