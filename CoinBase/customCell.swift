//
//  CustomCell.swift
//  CoinBase
//
//  Created by Iman Azher on 05/12/2024.
//

import UIKit

class CustomCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    // MARK: - Helper functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCells(model: PortfolioItem) {
        print(model.iconName)
        iconImageView.image = UIImage(named: model.iconName)
        titleLabel.text = model.itemName
        valueLabel.text = model.itemValue
        detailLabel.text = model.detail
        detailLabel.textColor = UIColor(red: 112/235, green: 112/235, blue: 112/235, alpha: 100)
    }

}
