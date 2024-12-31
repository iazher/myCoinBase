//
//  PolygonInformationCollectionViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

import UIKit

class PolygonInformationCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var videoLength: UILabel!
    @IBOutlet weak var valueTitle: UILabel! 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "Border custom gray")?.cgColor
    }

    func setValues(model: PolygonInfoModel) {
        title.text = model.title
        videoLength.text = model.videoLength + "min"
        valueTitle.text = "Earn " + model.value
    }
}
