//
//  ItemsFiltersCollectionViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 31/12/2024.
//

import UIKit

class ItemsFiltersCollectionViewCell: UICollectionViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var filterName: UILabel!
    
    //MARK: - Variables
    var selectedBgColor = UIColor(red: 245/255, green: 248/255, blue: 254/255, alpha: 1)
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Helper Functions
    func setSelectedState() {
        self.layer.cornerRadius = 10
        self.backgroundColor = selectedBgColor
        self.clipsToBounds = true
        filterName.textColor = UIColor(named: "Custom blue")
    }
    
    func resetState() {
        self.layer.cornerRadius = 0
        self.backgroundColor = .clear
        filterName.textColor = UIColor(named: "Custom black")
    }
    
    func setFilterName(name: String) {
        filterName.text = name
    }
}
