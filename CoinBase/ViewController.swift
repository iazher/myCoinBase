//
//  ViewController.swift
//  CoinBase
//
//  Created by Iman Azher on 29/11/2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeIconButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        if let button = sender as? UIButton{
            
          
            if button == eyeIconButton{
                if eyeIconButton.isSelected{
                    eyeIconButton.isSelected = false
                    passwordTextField.isSecureTextEntry = true
                }
                else{
                    eyeIconButton.isSelected = true
                    passwordTextField.isSecureTextEntry = false
                }
            }
            
            else if button == signInButton{
                let validEmail = isValidEmail(email: emailTextField.text!)
                let validPass = isValidPass(password: passwordTextField.text!)
                if (validEmail == false) || (validPass == false){
                    //POP UP SCREEN (ERROR)
                    var alertController = UIAlertController()
                    if (validEmail == false){
                        alertController = UIAlertController(title: "Error", message: "Invalid Email", preferredStyle: .alert)
                    }
                    else if (validPass == false){
                        alertController = UIAlertController(title: "Error", message: "Invalid Password", preferredStyle: .alert)
                    }
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        // Handle OK button tap
                        if validPass == false{
                            self.passwordTextField.text = ""
                        }
                    }

                    alertController.addAction(okAction)
                    present(alertController, animated: true, completion: nil)
                }
                else{
                    
                    //create Alert
                    let successAlertController = UIAlertController(title: "Success", message: "You've Logged In!", preferredStyle: .alert)
                    //add action (next)
                    let nextAction = UIAlertAction(title: "Next", style: .default){ _ in
                            //MOVE TO NEW SCREEN
                        self.performSegue(withIdentifier: "logInSuccess", sender: nil)
                    }
                    successAlertController.addAction(nextAction)
                    present(successAlertController, animated: true, completion: nil)
                }
            }
            
            else if button == rememberMeButton{
                if rememberMeButton.isSelected == false{
                    rememberMeButton.isSelected = true
                    UserDefaults.standard.set(emailTextField.text, forKey: "userEmail")
                    UserDefaults.standard.set(passwordTextField.text, forKey: "userPassword")
                    
                }
                else{
                    rememberMeButton.isSelected = false
                }
            }
        }
    }
    
    
    @IBAction func textFieldEditingBegin(_ sender: Any) {
        //make changes to text field when user starts input
        let myColour = UIColor.systemBlue
        if let textField = sender as? UITextField {
            if textField == passwordTextField{
                    passwordLabel.textColor = .systemBlue
                    eyeIconButton.isHidden = false
                    eyeIconButton.isEnabled = true
            }
            
            else if textField == emailTextField{
                let existingEmail = UserDefaults.standard.string(forKey: "userEmail")
                if existingEmail != nil{
                    print(existingEmail!)
                }
                    emailLabel.textColor = .systemBlue
            }
            textField.layer.cornerRadius = 4
            textField.layer.borderWidth = 2
            textField.layer.borderColor = myColour.cgColor
            
        }
    }
    
    @IBAction func textFieldEditingEnd(_ sender: Any) {
        if let textField = sender as? UITextField {
            if textField == passwordTextField{
                passwordLabel.textColor = .black
            }
            else if textField == emailTextField{
                emailLabel.textColor = .black
            }
            textField.layer.cornerRadius = 0
            textField.layer.borderWidth = 0
            textField.layer.borderColor = UIColor.clear.cgColor        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField{
            let charAfterUse = textField.text!.count + 1
            // user not allowed to enter Space and characters > 8
            if (charAfterUse > 8) || (string == " "){
                return false
            }
        }
        return true
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
        if ((!hasSpecialCharacter) || (!hasNumbers) || (!hasUpperCase)){
            return false
        }
        return true
    }

    
    

}

