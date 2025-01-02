//
//  SignOutButtonTVCell.swift
//  CoinBase
//
//  Created by Iman Azher on 02/01/2025.
//

import UIKit

class SignOutButtonTVCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var signOutBtn: UIButton! {
        didSet {
            signOutBtn.layer.cornerRadius = 8
            signOutBtn.layer.borderWidth = 1
            signOutBtn.layer.borderColor = UIColor(named: "Border custom gray")?.cgColor
        }
    }
    
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
    func setAppVersion(version: String) {
        appVersionLabel.text = "App Version: \(version)"
    }
}
