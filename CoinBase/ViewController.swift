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
            emailTextField.layer.borderColor = UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.cornerRadius = 4
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var eyebtn: UIButton!
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        passwordTextField.delegate = self
        emailTextField.delegate = self
        setupRememberMeBtnOnStartup()
    }
    
    // MARK: - Variables & Constants
    let customBlue = UIColor(red: 39/255, green: 82/255, blue: 231/255, alpha: 1)
    let customBlack = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
    let customGray =  UIColor(red: 207/235, green: 207/235, blue: 207/235, alpha: 1)
    
    // to store the current active textfield
     var activeTextField : UITextField? = nil
    
    enum ValidationResult {
        case success
        case invalidEmail
        case invalidPassword
        
        var message: String {
            switch self {
            case .success:
                return "You've logged In"
            case .invalidEmail:
                return "Invalid Email"
            case .invalidPassword:
                return "Invalid Password"
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
        if isValidEmail(email: email) {
            if isValidPass(password: password) {
                return .success
            } else {
                passwordTextField.text = ""
                passwordTextField.becomeFirstResponder()
                return .invalidPassword
            }
        } else {
            emailTextField.text = ""
            emailTextField.becomeFirstResponder()
            return .invalidEmail
        }
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
        navigationController?.popViewController(animated: true)
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
        sender.layer.borderColor = customBlue.cgColor
    }
    
    @IBAction func passwordTextFieldEditingBegin(_ sender: UITextField) {
        passwordLabel.textColor = customBlue
        sender.layer.borderColor = customBlue.cgColor
    }
    
    @IBAction func emailTextFieldEditingEnd(_ sender: UITextField) {
        emailLabel.textColor = customBlack
        sender.layer.borderColor = customGray.cgColor
    }
    
    @IBAction func passTextFieldEditingEnd(_ sender: UITextField) {
        passwordLabel.textColor = customBlack
        sender.layer.borderColor = customGray.cgColor
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


