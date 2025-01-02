//
//  CountryCodesTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 23/12/2024.
//

import UIKit

class CountryCodesTableViewCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCode: UILabel!
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helper Functions
    func setValues(model: CountryCodesModel) {
        countryName.text = model.countryName
        countryCode.text = model.countryCode
    }
}
