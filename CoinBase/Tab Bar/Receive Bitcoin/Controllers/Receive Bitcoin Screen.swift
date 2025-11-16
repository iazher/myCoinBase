//
//  Receive Bitcoin Screen.swift
//  CoinBase
//
//  Created by Iman Azher on 02/01/2025.
//

import Foundation
import UIKit

class ReceiveBitcoin: UIViewController {
    
    @IBOutlet weak var walletAddress: UILabel! {
        didSet {
            setWalletAddress()
        }
    }
    
    @IBOutlet weak var shareBtn: UIButton! {
        didSet {
            shareBtn.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var copyBtn: UIButton! {
        didSet {
            copyBtn.layer.cornerRadius = 4
            copyBtn.layer.borderWidth = 1
            copyBtn.layer.borderColor = UIColor(named: "Custom border gray")?.cgColor
        }
    }
    
    @IBOutlet weak var outerView: UIView! {
        didSet {
            outerView.layer.cornerRadius = 10
            outerView.layer.borderWidth = 1
            outerView.layer.borderColor = UIColor(named: "Custom border gray")?.cgColor
        }
    }
    
    func setWalletAddress() {
        walletAddress.text = "3K9CKsePi...Df5NfQh7iK"
    }
}
