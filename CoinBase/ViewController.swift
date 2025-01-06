//
//  ViewController.swift
//  CoinBase
//
//  Created by Iman Azher on 29/11/2024.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var scrollViewSignIn: UIScrollView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.layer.cornerRadius = 4
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = UIColor(named: "Custom border gray")?.cgColor
        }
    }
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.cornerRadius = 4
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor(named: "Custom border gray")?.cgColor
        }
    }
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var eyebtn: UIButton!
    
    //MARK: - Variables
    let userEmail = "janedoe@gmail.com"
    let userPassword = "Abc1234!"
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        passwordTextField.delegate = self
        emailTextField.delegate = self
        setupRememberMeBtnOnStartup()
    }
    
    // MARK: - Variables & Constants
    let customBlue = UIColor(named: "Custom blue")
    let customBlack = UIColor(named: "Custom black")
    let customBorderGray =  UIColor(named: "Custom border gray")

    
    enum ValidationResult {
        case success
        case invalidEmail
        case invalidPassword
        case incorrectEmail
        case incorrectPass
        
        var message: String {
            switch self {
            case .success:
                return "You've logged In"
            case .invalidEmail:
                return "Invalid Email"
            case .invalidPassword:
                return "Invalid Password"
            case .incorrectEmail:
                return "Incorrect Email"
            case .incorrectPass:
                return "Incorrect Password"
            }
        }
    }
    
    // MARK: - Helper Funcions
    func setupRememberMeBtnOnStartup() {
        if let email = UserDefaults.standard.value(forKey: "userEmail") as? String , let password = UserDefaults.standard.value(forKey: "userPassword") as? String {
            rememberMeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            emailTextField.text = email
            passwordTextField.text = password
            rememberMeButton.tag = 1
        }
    }

    func validateFields(email: String, password: String) -> ValidationResult {
        if email.isValidEmail() { //valid email
            if isCorrectEmail(inputEmail: email) {  //correct email
                if password.isValidPassword() {    //valid pass
                    if isCorrectPass(inputPass: password) {
                        return .success
                    } else {    //correct pass
                        passwordTextField.text = ""
                        passwordTextField.becomeFirstResponder()
                        return .incorrectPass
                    }
                } else {    //incorrect pass
                    passwordTextField.text = ""
                    passwordTextField.becomeFirstResponder()
                    return .invalidPassword
                }
            } else {    //incorrect email
                return .incorrectEmail
            }
        } else {    //invalid email
            emailTextField.text = ""
            emailTextField.becomeFirstResponder()
            return .invalidEmail
        }
    }
    
    func isCorrectEmail(inputEmail: String) -> Bool {
        return inputEmail == userEmail
    }
    
    func isCorrectPass(inputPass: String) -> Bool {
        return inputPass == userPassword
    }
    
    func showPopup(result: ValidationResult) {
        let successAlertController = UIAlertController(title: "Error", message: result.message, preferredStyle: .alert)
        let nextAction = UIAlertAction(title: "Ok", style: .default)
        successAlertController.addAction(nextAction)
        present(successAlertController, animated: true, completion: nil)
    }
    
    func navigateToScreen(_ identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPass(password: String) -> Bool{
        //check for atleast one special character
        var regexPass = ".*[^A-Za-z0-9].*"
        let predicateSpecialChar = NSPredicate(format:"SELF MATCHES %@", regexPass)
        let hasSpecialCharacter = predicateSpecialChar.evaluate(with: password)
        
        //check for atleast one Upper case letter
        regexPass = ".*[A-Z].*"
        let predicateUpperCase = NSPredicate(format:"SELF MATCHES %@", regexPass)
        let hasUpperCase = predicateUpperCase.evaluate(with: password)
        
        //check for atleast one integer
        let numbersRange = password.rangeOfCharacter(from: .decimalDigits)
        let hasNumbers = (numbersRange != nil)
        if ((hasSpecialCharacter == false) || (hasNumbers == false) || (hasUpperCase == false)) {
            return false
        }
        return true
    }
    
    // MARK: - IBActions
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        let errorResult = validateFields(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        
        if errorResult == .success {
            navigateToScreen("SignInVerification")
        } else {
            showPopup(result: errorResult)
        }
    }
    
    @IBAction func rememberMeBtnTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            UserDefaults.standard.set(emailTextField.text, forKey: "userEmail")
            UserDefaults.standard.set(passwordTextField.text, forKey: "userPassword")
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            sender.tag = 1
        } else {
            UserDefaults.standard.removeObject(forKey: "userEmail")
            UserDefaults.standard.removeObject(forKey: "userPassword")
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            sender.tag = 0
        }
    }
    
    @IBAction func eyeBtnTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            eyebtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            sender.tag = 1
        } else {
            eyebtn.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            sender.tag = 0
        }
    }
    
    // MARK: - Textfield actions
    @IBAction func emailTextFieldEditingBegin(_ sender: UITextField) {
        emailLabel.textColor = customBlue
        sender.layer.borderColor = customBlue?.cgColor
    }
    
    @IBAction func passwordTextFieldEditingBegin(_ sender: UITextField) {
        passwordLabel.textColor = customBlue
        sender.layer.borderColor = customBlue?.cgColor
    }
    
    @IBAction func emailTextFieldEditingEnd(_ sender: UITextField) {
        emailLabel.textColor = customBlack
        sender.layer.borderColor = customBorderGray?.cgColor
    }
    
    @IBAction func passTextFieldEditingEnd(_ sender: UITextField) {
        passwordLabel.textColor = customBlack
        sender.layer.borderColor = customBorderGray?.cgColor
    }
}

// MARK: - Text field Delegates
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        if textField == passwordTextField{
            let charAfterUse = textField.text!.count + 1
            if (charAfterUse > 8) || (string == " ") {
                return false
            }
        }
        return true
    }
}

extension String {
    // Validates if the string is a valid email address
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    /* Validates if the string meets password requirements
     - At least one special character
     - At least one uppercase letter
     - At least one number */
    func isValidPassword() -> Bool {
        // Check for at least one special character
        let specialCharacterRegex = ".*[^A-Za-z0-9].*"
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        let hasSpecialCharacter = specialCharacterPredicate.evaluate(with: self)
        
        // Check for at least one uppercase letter
        let uppercaseRegex = ".*[A-Z].*"
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
        let hasUpperCase = uppercasePredicate.evaluate(with: self)
        
        // Check for at least one number
        let hasNumbers = self.rangeOfCharacter(from: .decimalDigits) != nil
        return hasSpecialCharacter && hasUpperCase && hasNumbers
    }
    
    func capitalizeFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

