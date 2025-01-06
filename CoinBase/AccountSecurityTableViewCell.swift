//
//  SettingsCustomArrowTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 01/01/2025.
//

import UIKit

protocol SecuritySectionDelegate {
    func showPopUp(message: String) 
}

class AccountSecurityTableViewCell: UITableViewCell {
    
    //MARK: - IB Outlets
    @IBOutlet weak var additionalInfo: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var securitySwitch: UISwitch!
    @IBOutlet weak var arrowBtn: UIButton!
    
    //MARK: - Variables
    var delegate: SecuritySectionDelegate?
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - IB Actions
    @IBAction func arrowBtnTapped(_ sender: UIButton) {
        //add functionality here
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        //show popup
        var message: String
        switch(securitySwitch.isOn) {
        case true:
            if title.text == "Require PIN / Face ID" {
                message = "User will be asked for PIN/Face ID when signing in"
            } else {
                message = "Privacy mode enabled"
            }
        case false:
            if title.text == "Privacy mode" {
                message = "Privacy mode disabled"
            } else {
                message = "User will not be asked for PIN/Face ID when signing in"
            }
        }
        delegate?.showPopUp(message: message)
    }
    
    //MARK: - Helper Functions
    func setData(model: AccountSecurityModel) {
        title.text = model.title
        additionalInfo.text = model.additionalInfo
    }
}
