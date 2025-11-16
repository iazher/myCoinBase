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
    let customBorderGray = UIColor(named: "Custom border gray")
    let customBlue = UIColor(named: "Custom blue")
    let customBlack = UIColor(named: "Custom black")
    let validationCode: String = "7754397"
    
    // MARK: - IB Actions
    @IBAction func verificationFieldEditingBegin(_ sender: UITextField) {
        sender.layer.borderColor = customBlue?.cgColor
    }
    
    @IBAction func verificationFieldEditingEnd(_ sender: UITextField) {
        sender.layer.borderColor = customBlack?.cgColor
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        if verificationTextField.text == validationCode {
            UserDefaults.standard.set(true, forKey: "LoggedIn")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabbarController") as? TabbarController
            self.navigationController?.pushViewController(vc!, animated: true)
        } else {
            showPopup()
            verificationTextField.text = ""
            verificationTextField.becomeFirstResponder()
        }
    }
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationTextField.delegate = self
        roundBtnCorners()
        setBordersColors()
    }
    
    // MARK: - Helper Functions
    func setBordersColors() {
        verificationTextField.layer.borderColor = customBorderGray?.cgColor
        helpBtn.layer.borderColor = customBorderGray?.cgColor
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

//MARK: - Text Field Delegates
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
