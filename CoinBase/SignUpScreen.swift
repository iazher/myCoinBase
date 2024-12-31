//
//  SingUpScreen.swift
//  CoinBase
//
//  Created by Iman Azher on 23/12/2024.
//

import UIKit

class SignUpScreen: UIViewController {
    
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
    
    let customBlue = UIColor(red: 39/255, green: 82/255, blue: 231/255, alpha: 1)
    let customBlack = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
    let customGray =  UIColor(red: 207/235, green: 207/235, blue: 207/235, alpha: 1)
   
    // to store the current active textfield
     var activeTextField : UITextField? = nil
    
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
        self.activeTextField = sender
        firstNameLabel.textColor = customBlue
        sender.layer.borderColor = customBlue.cgColor
    }
    
    @IBAction func lastNameTextFieldEditingBegin(_ sender: UITextField) {
        self.activeTextField = sender
        lastNameLabel.textColor = customBlue
        sender.layer.borderColor = customBlue.cgColor
    }
    
    @IBAction func emailTextFieldEditingBegin(_ sender: UITextField) {
        self.activeTextField = sender
        emailLabel.textColor = customBlue
        sender.layer.borderColor = customBlue.cgColor
    }
    
    @IBAction func passwordTextFieldEditingBegin(_ sender: UITextField) {
        self.activeTextField = sender
        passwordLabel.textColor = customBlue
        sender.layer.borderColor = customBlue.cgColor
    }
    
    @IBAction func firstNameTextFieldEditingEnd(_ sender: UITextField) {
        self.activeTextField = nil
        firstNameLabel.textColor = customBlack
        sender.layer.borderColor = customGray.cgColor
    }
    
    @IBAction func lastNameTextFieldEditingEnd(_ sender: UITextField) {
        self.activeTextField = nil
        lastNameLabel.textColor = customBlack
        sender.layer.borderColor = customGray.cgColor
    }
    
    @IBAction func emailTextFieldEditingEnd(_ sender: UITextField) {
        emailLabel.textColor = customBlack
        sender.layer.borderColor = customGray.cgColor
    }
    
    @IBAction func passTextFieldEditingEnd(_ sender: UITextField) {
        passwordLabel.textColor = customBlack
        sender.layer.borderColor = customGray.cgColor
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
            navigateToScreen("EmailVerificationScreen1")
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

//MARK: - Text Field Delegate and Keyboard Handling
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

//MARK: - Validation using string extension
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
}
