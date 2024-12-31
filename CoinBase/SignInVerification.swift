//
//  verification.swift
//  CoinBase
//
//  Created by Iman Azher on 23/12/2024.
//

import UIKit

class Verification: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var helpBtn: UIButton! {
        didSet {
            helpBtn.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var verificationTextField: UITextField! {
        didSet {
            verificationTextField.layer.borderWidth = 1
            verificationTextField.layer.cornerRadius = 4
        }
    }
    
    //MARK: - Variables
    let customBorderGray = UIColor(red: 207/235, green: 207/235, blue: 207/235, alpha: 1).cgColor
    let customBlue = UIColor(red: 39/255, green: 82/255, blue: 231/255, alpha: 1)
    let customBlack = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
    
    let validationCode: String = "7754397"
    
    // MARK: - IB Actions

    @IBAction func verificationFieldEditingBegin(_ sender: UITextField) {
        //add functionality
        sender.layer.borderColor = customBlue.cgColor
    }
    
    @IBAction func verificationFieldEditingEnd(_ sender: UITextField) {
        //add functionality
        sender.layer.borderColor = customBlack.cgColor
        
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        if verificationTextField.text == validationCode {
            navigateToScreen("SignInSuccess")
        } else {
            showPopup()
            verificationTextField.text = ""
            verificationTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func helpBtnTapped(_ sender: UIButton) {
        //maybe ????
    }
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationTextField.delegate = self
        roundBtnCorners()
        setBordersColors()
    }
    
    // MARK: - Helper Functions
    
    func navigateToScreen(_ identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func setBordersColors() {
        verificationTextField.layer.borderColor = customBorderGray
        helpBtn.layer.borderColor = customBorderGray
    }
    func roundBtnCorners() {
        submitBtn.layer.cornerRadius = 8
        helpBtn.layer.cornerRadius = 8
    }
    
    func showPopup() {
            let alertController = UIAlertController(title: "Error", message: "Invalid Code", preferredStyle: .alert)
            let nextAction = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(nextAction)
            present(alertController, animated: true, completion: nil)
        }
}

extension Verification: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        if textField == verificationTextField {
            let charAfterUse = textField.text!.count + 1
            var isNumber = false
            if let _ = Int(string) {
                isNumber = true
            }
            if (charAfterUse > 7) || (string == " ") || (isNumber == false) {
                return false
            }
        }
        return true
    }
}
