//
//  SignOutButtonTVCell.swift
//  CoinBase
//
//  Created by Iman Azher on 02/01/2025.
//

import UIKit

protocol SignOutBtnDelegate {
    func signOut()
}

class SignOutButtonTVCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var signOutBtn: UIButton! {
        didSet {
            signOutBtn.layer.cornerRadius = 8
            signOutBtn.layer.borderWidth = 1
            signOutBtn.layer.borderColor = UIColor(named: "Custom border gray")?.cgColor
        }
    }
    
    //MARK: - Variables
    var delegate: SignOutBtnDelegate?
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func signOutBtnTapped(_ sender: UIButton) {
        delegate?.signOut()
    }
    
    //MARK: - Helper Functions
    func setAppVersion(version: String) {
        appVersionLabel.text = "App Version: \(version)"
    }
}
