//
//  CustomLaunchScreen.swift
//  CoinBase
//
//  Created by Iman Azher on 06/01/2025.
//

import UIKit

class CustomLaunchScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setRootController()
    }
    
    func setRootController() {
        if let loggedIn = UserDefaults.standard.value(forKey: "LoggedIn") as? Bool {
            if loggedIn {
                //self.performSegue(withIdentifier: "initiateWithTabBar", sender: nil)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabbarController") as? TabbarController
                    self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                //self.performSegue(withIdentifier: "MainScreen" , sender: nil)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInSignUpScreen") as? SignInSignUpScreen
                    self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    
}
