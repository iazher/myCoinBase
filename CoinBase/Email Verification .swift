//
//  Email Verification .swift
//  CoinBase
//
//  Created by Iman Azher on 23/12/2024.
//

import UIKit

class EmailVerification: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var checkInboxBtn: UIButton! {
        didSet {
            checkInboxBtn.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var resendEmailBtn: UIButton! {
        didSet {
            resendEmailBtn.layer.borderColor = UIColor(red: 207/235, green: 207/235, blue: 207/235, alpha: 1).cgColor
            resendEmailBtn.layer.borderWidth = 1
            resendEmailBtn.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var letsGoBtn: UIButton! {
        didSet {
            letsGoBtn.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var doneBtn: UIButton! {
        didSet {
            doneBtn.layer.cornerRadius = 8
        }
    }
    
    //MARK: - Action Outlets
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkInboxBtnTapped(_ sender: UIButton) {
        //navigate from here to next screen
        navigateToScreen("EmailVerificationScreen2")
    }
    
    @IBAction func resendEmailBtnTapped(_ sender: UIButton) {
        //add functionality here
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        if sender == letsGoBtn {
            navigateToScreen("EmailVerificationScreen3")
        }
        else if sender == doneBtn {
            navigateToScreen("2StepVerificationScreen1")
        }
    }
    
    //MARK: - Helper Functions
    func navigateToScreen(_ identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
}

