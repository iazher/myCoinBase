//
//  SignInSingUpScreen.swift
//  CoinBase
//
//  Created by Iman Azher on 23/12/2024.
//

import UIKit

class SignInSignUpScreen: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var getStartedBtn: UIButton! {
        didSet {
            roundBtnCorners()
        }
    }
    
    @IBOutlet weak var signInBtn: UIButton!
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - IB Actions
    @IBAction func getStartedBtnTapped(_ sender: UIButton) {
        navigateToScreen("SignUpScreen")
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        navigateToScreen("SignInScreen")
    }
    
    //MARK: - Helper Functions
    func roundBtnCorners() {
        getStartedBtn.layer.cornerRadius = 8
        getStartedBtn.clipsToBounds = true
    }
    
    func navigateToScreen(_ identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
}
