//
//  DoMoreCollectionViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

import UIKit

class DoMoreCollectionViewCell: UICollectionViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellBorders()
        setValues()
    }

    //MARK: - Helper Functions
    func setValues() {
        title.text = "Earn rewards"
        detail.text = "Invite a friend to Coinbase and you’ll both get $10"
    }
    
    func setCellBorders() {
        self.layer.borderColor = UIColor(named: "Border custom gray")?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
}
