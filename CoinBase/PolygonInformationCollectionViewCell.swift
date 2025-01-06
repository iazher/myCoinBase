//
//  PolygonInformationCollectionViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

import UIKit

class PolygonInformationCollectionViewCell: UICollectionViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var videoLength: UILabel!
    @IBOutlet weak var valueTitle: UILabel! 

    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "Custom border gray")?.cgColor
    }

    //MARK: - Helper Functions
    func setValues(model: PolygonInfoModel) {
        title.text = model.title
        videoLength.text = model.videoLength + "min"
        valueTitle.text = "Earn " + model.value
    }
}
