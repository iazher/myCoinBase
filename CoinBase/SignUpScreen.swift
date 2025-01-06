//
//  SingUpScreen.swift
//  CoinBase
//
//  Created by Iman Azher on 23/12/2024.
//

import UIKit

class SignUpScreen: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var scrollViewSignUp: UIScrollView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            setTextFieldBorders(textField: firstNameTextField)
        }
    }
    
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            setTextFieldBorders(textField: lastNameTextField)
        }
    }
    
    @IBOutlet weak var signUpEmailTextField: UITextField! {
        didSet {
            setTextFieldBorders(textField: signUpEmailTextField)
        }
    }
    
    @IBOutlet weak var signUpPasswordTextField: UITextField! {
        didSet {
            setTextFieldBorders(textField: signUpPasswordTextField)
        }
    }
    
    @IBOutlet weak var startBtn: UIButton! {
        didSet {
            startBtn.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var agreementBtn: UIButton!
    @IBOutlet weak var looksGoodLabel: UILabel! {
        didSet {
            looksGoodLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var looksGoodCheckMark: UIImageView! {
        didSet {
            looksGoodCheckMark.isHidden = true
        }
    }
    
    //MARK: - Variables
    let customBlue = UIColor(named: "Custom blue")
    let customBlack = UIColor(named: "Custom black")
    let customBorderGray =  UIColor(named: "Custom border gray")
    
    enum ValidationResult {
        case success
        case invalidEmail
        case invalidPassword
        case boxNotChecked
        
        var message: String {
            switch self {
            case .success:
                return "You've logged In"
            case .invalidEmail:
                return "Invalid Email"
            case .invalidPassword:
                return "Invalid Password"
            case .boxNotChecked:
                return "Agree to the User agreement and Privacy policy to continue"
            }
        }
    }
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        signUpEmailTextField.delegate = self
        signUpPasswordTextField.delegate = self
        agreementBtnSetUp()
    }
    
    //MARK: - IB Actions
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func agreementBtnTapped(_ sender: UIButton) {
        if agreementBtn.tag == 0 {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tag = 1
        }
        else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            sender.tag = 0
        }
    }
    
    @IBAction func eyeBtnTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            signUpPasswordTextField.isSecureTextEntry = false
            sender.tag = 1
        } else {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
            signUpPasswordTextField.isSecureTextEntry = true
            sender.tag = 0
        }
    }
    
    @IBAction func startBtnTapped(_ sender: UIButton) {
        let errorResult = validateFields(email: signUpEmailTextField.text ?? "", password: signUpPasswordTextField.text ?? "")
        //handle success (navigate to next screen)
        showPopup(result: errorResult)
    }
    
    @IBAction func firstNameTextFieldEditingBegin(_ sender: UITextField) {
        firstNameLabel.textColor = customBlue
        sender.layer.borderColor = customBlue?.cgColor
    }
    
    @IBAction func lastNameTextFieldEditingBegin(_ sender: UITextField) {
        lastNameLabel.textColor = customBlue
        sender.layer.borderColor = customBlue?.cgColor
    }
    
    @IBAction func emailTextFieldEditingBegin(_ sender: UITextField) {
        emailLabel.textColor = customBlue
        sender.layer.borderColor = customBlue?.cgColor
    }
    
    @IBAction func passwordTextFieldEditingBegin(_ sender: UITextField) {
        passwordLabel.textColor = customBlue
        sender.layer.borderColor = customBlue?.cgColor
    }
    
    @IBAction func firstNameTextFieldEditingEnd(_ sender: UITextField) {
        let text = firstNameTextField.text
        firstNameTextField.text = text?.capitalizeFirst()
        firstNameLabel.textColor = customBlack
        sender.layer.borderColor = customBorderGray?.cgColor
    }
    
    @IBAction func lastNameTextFieldEditingEnd(_ sender: UITextField) {
        let text = lastNameTextField.text
        lastNameTextField.text = text?.capitalizeFirst()
        lastNameLabel.textColor = customBlack
        sender.layer.borderColor = customBorderGray?.cgColor
    }
    
    @IBAction func emailTextFieldEditingEnd(_ sender: UITextField) {
        emailLabel.textColor = customBlack
        sender.layer.borderColor = customBorderGray?.cgColor
    }
    
    @IBAction func passTextFieldEditingEnd(_ sender: UITextField) {
        passwordLabel.textColor = customBlack
        sender.layer.borderColor = customBorderGray?.cgColor
    }
    
    //MARK: - Helper Functions
    func navigateToScreen(_ identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func setTextFieldBorders(textField: UITextField) {
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1).cgColor
    }
    
    func agreementBtnSetUp() {
        agreementBtn.tag = 0
    }
    
    func validateFields(email: String, password: String) -> ValidationResult {
        if email.isValidEmail() {
            if password.isValidPassword() {
                if agreementBtn.tag == 1 {
                    return .success
                } else {
                    return .boxNotChecked
                }
            } else {
                signUpPasswordTextField.text = ""
                signUpPasswordTextField.becomeFirstResponder()
                return .invalidPassword
            }
        } else {
            signUpEmailTextField.text = ""
            signUpEmailTextField.becomeFirstResponder()
            return .invalidEmail
        }
    }
    
    func showPopup(result: ValidationResult) {
        if result == .success {
            navigateToScreen("TwoStepVerification")
        } else {
            let successAlertController = UIAlertController(title: "Error", message: result.message, preferredStyle: .alert)
            let nextAction = UIAlertAction(title: "Ok", style: .default)
            successAlertController.addAction(nextAction)
            present(successAlertController, animated: true, completion: nil)
        }
    }
    
    func looksGoodHandling() {
        if let result = signUpPasswordTextField.text?.isValidPassword() {
            if result == true {
                looksGoodLabel.isHidden = false
                looksGoodCheckMark.isHidden = false
            }
            else {
                looksGoodLabel.isHidden = true
                looksGoodCheckMark.isHidden = true
            }
        }
    }
}

//MARK: - Text Field Delegates
extension SignUpScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        if textField == signUpPasswordTextField{
            looksGoodHandling()
            let charAfterUse = textField.text!.count + 1
            if (charAfterUse > 8) || (string == " ") {
                return false
            }
        }
        return true
    }
}
