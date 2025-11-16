//
//  New User Authentication Code.swift
//  CoinBase
//
//  Created by Iman Azher on 24/12/2024.
//

import UIKit
import Foundation

class NewUserAuthentication: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField! {
        didSet {
            setTextFieldBorders(textField: codeTextField)
        }
    }
    
    @IBOutlet weak var continueBtn: UIButton! {
        didSet {
            continueBtn.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var resendBtn: UIButton! {
        didSet {
            resendBtn.layer.borderColor = customBorderGray?.cgColor
            resendBtn.layer.borderWidth = 1
            resendBtn.layer.cornerRadius = 8
        }
    }
    
    //MARK: - Variables
    let customBorderGray =  UIColor(named: "Custom border gray")
    let customBlue = UIColor(named: "Custom blue")
    let customBlack = UIColor(named: "Custom black")
    var randomCode: String = ""
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        codeTextField.delegate = self
        randomCode = generateRandomCode()
        print(randomCode)
    }
    
    //MARK: - IB Actions
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnTapped(_ sender: UIButton) {
        //navigate to home screen if code matches
        if codeTextField.text == randomCode {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmailVerification") as? EmailVerification
            self.navigationController?.pushViewController(vc!, animated: true)
            
        } else {
            showPopup()
            randomCode = generateRandomCode()
            print(randomCode)
            codeTextField.text = ""
            codeTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func resendBtnTapped(_ sender: UIButton) {
        randomCode = generateRandomCode()
        print(randomCode)
        codeTextField.becomeFirstResponder()
        codeTextField.text = ""
    }
    
    @IBAction func textFieldEditingBegin(_ sender: UITextField) {
        codeLabel.textColor = customBlue
        sender.layer.borderColor = customBlue?.cgColor
        sender.layer.borderWidth = 2
    }
    
    //MARK: - Helper Functions
    func setTextFieldBorders(textField: UITextField) {
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = customBorderGray?.cgColor
    }
    
    func showPopup() {
        let alertController = UIAlertController(title: "Error", message: "Invalid Code", preferredStyle: .alert)
        let nextAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(nextAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func generateRandomCode() -> String {
        // Default to 1000000 if nil
            return String((1000000...9999999).randomElement() ?? 1000000)
    }

}

//MARK: - TextField Delegates
extension NewUserAuthentication: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        if textField == codeTextField {
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
