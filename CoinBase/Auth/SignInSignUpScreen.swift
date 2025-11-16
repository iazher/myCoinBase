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
    }
    
    //MARK: - IB Actions
    @IBAction func getStartedBtnTapped(_ sender: UIButton) {
        //    navigateToScreen("SignUpScreen")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpScreen") as? SignUpScreen
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //MARK: - Helper Functions
    func roundBtnCorners() {
        getStartedBtn.layer.cornerRadius = 8
        getStartedBtn.clipsToBounds = true
    }
}
