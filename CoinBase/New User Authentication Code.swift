//
//  New User Authentication Code.swift
//  CoinBase
//
//  Created by Iman Azher on 24/12/2024.
//

import UIKit

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
            resendBtn.layer.borderColor = customGray.cgColor
            resendBtn.layer.borderWidth = 1
            resendBtn.layer.cornerRadius = 8
        }
    }
    
    //MARK: - Variables
    let customGray =  UIColor(red: 207/235, green: 207/235, blue: 207/235, alpha: 1)
    let customBlue = UIColor(red: 39/255, green: 82/255, blue: 231/255, alpha: 1)
    let customBlack = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
    let codeToMatch: String = "7215706" //compare user code to this code
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        codeTextField.delegate = self
    }
    
    //MARK: - IB Actions
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnTapped(_ sender: UIButton) {
        //navigate to home screen if code matches
        if codeTextField.text == codeToMatch {
            navigateToScreen("SignUpSuccess")
        } else {
            showPopup()
            codeTextField.text = ""
            codeTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func resendBtnTapped(_ sender: UIButton) {
        codeTextField.becomeFirstResponder()
        codeTextField.text = ""
    }
    
    @IBAction func textFieldEditingBegin(_ sender: UITextField) {
        codeLabel.textColor = customBlue
        sender.layer.borderColor = customBlue.cgColor
        sender.layer.borderWidth = 2
    }
    
    //MARK: - Helper Functions
    func navigateToScreen(_ identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func setTextFieldBorders(textField: UITextField) {
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = customGray.cgColor
    }
    
    func showPopup() {
        let alertController = UIAlertController(title: "Error", message: "Invalid Code", preferredStyle: .alert)
        let nextAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(nextAction)
        present(alertController, animated: true, completion: nil)
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
