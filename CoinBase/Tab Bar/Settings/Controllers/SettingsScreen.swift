//
//  SettingsScreen.swift
//  CoinBase
//
//  Created by Iman Azher on 01/01/2025.
//

import Foundation
import UIKit

class SettingsScreen: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var settingsTV: UITableView! {
        didSet {
            registerTVCells()
            settingsTV.delegate = self
            settingsTV.dataSource = self
            settingsTV.sectionHeaderTopPadding = 0
            settingsTV.showsVerticalScrollIndicator = false
        }
    }

    //MARK: - Variables
    var accountListItems = [
        AccountSecurityModel(
            title: "Limits and features",
            additionalInfo: ""
        ),
        AccountSecurityModel(
            title: "Native currency",
            additionalInfo: ""
        ),
        AccountSecurityModel(
            title: "Country",
            additionalInfo: ""
        ),
        AccountSecurityModel(
            title: "Privacy",
            additionalInfo: ""
        ),
        AccountSecurityModel(
            title: "Phone numbers",
            additionalInfo: ""
        ),
        AccountSecurityModel(
            title: "Notification settings",
            additionalInfo: ""
        )
    ]
    
    var settingsListItems = [
        AccountSecurityModel(
            title: "Require PIN / Face ID",
            additionalInfo: ""
        ),
        AccountSecurityModel(
            title: "PIN/ Face ID settings",
            additionalInfo: ""
        ),
        AccountSecurityModel(
            title: "Privacy mode",
            additionalInfo: "Long press on your portfolio balance to hide your balances everywhere in the app"
        ),
        AccountSecurityModel(
            title: "Support",
            additionalInfo: ""
        )
    ]

    //MARK: - Helper Functions
    func registerTVCells() {
        //custom cells
        settingsTV.register(UINib(nibName: "PromoTableViewCell", bundle: nil), forCellReuseIdentifier: "PromoTableViewCell")
        settingsTV.separatorStyle = .none
        
        settingsTV.register(UINib(nibName: "PaymentButtonTVCell", bundle: nil), forCellReuseIdentifier: "PaymentButtonTVCell")
        settingsTV.separatorStyle = .none
        
        settingsTV.register(UINib(nibName: "AccountSecurityTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountSecurityTableViewCell")
        settingsTV.separatorStyle = .none
        
        settingsTV.register(UINib(nibName: "SignOutButtonTVCell", bundle: nil), forCellReuseIdentifier: "SignOutButtonTVCell")
        settingsTV.separatorStyle = .none
        
        //custom headers
        settingsTV.register(UINib(nibName: "SettingsPromoCustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SettingsPromoCustomHeader")
        
        settingsTV.register(UINib(nibName: "SettingsPlainHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SettingsPlainHeader")
    }
}

//MARK: - Table View Delegates
extension SettingsScreen: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return accountListItems.count
        case 3:
            return settingsListItems.count
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromoTableViewCell", for: indexPath) as? PromoTableViewCell else {
                    return PromoTableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentButtonTVCell", for: indexPath) as? PaymentButtonTVCell else {
                return PaymentButtonTVCell()
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSecurityTableViewCell", for: indexPath) as? AccountSecurityTableViewCell else {
                return AccountSecurityTableViewCell()
            }
            cell.setData(model: accountListItems[indexPath.row])
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSecurityTableViewCell", for: indexPath) as? AccountSecurityTableViewCell else {
                return AccountSecurityTableViewCell()
            }
            
            let item = settingsListItems[indexPath.row]
            if item.title == "Require PIN / Face ID" {
                cell.securitySwitch.isHidden = false
                cell.securitySwitch.isOn = false
                cell.arrowBtn.isHidden = true
            } else if item.title == "Privacy mode" {
                cell.securitySwitch.isHidden = false
                cell.arrowBtn.isHidden = true
            }
            cell.delegate = self
            cell.setData(model: settingsListItems[indexPath.row])
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignOutButtonTVCell", for: indexPath) as? SignOutButtonTVCell else {
                return SignOutButtonTVCell()
            }
            cell.setAppVersion(version: "9.26.4 (92604), production")
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 106
        case 1:
            return 58
        case 2:
            return 56 //40 + empty view(16)
        case 3:
            if indexPath.row == 2 {
                return UITableView.automaticDimension
            }
            return 56
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SettingsPromoCustomHeader") as? SettingsPromoCustomHeader else {
                return nil
            }
            header.setUserName(name: "YuanPin, Ivy Xu")
            header.setUserEmail(email: "user@example.com")
            header.backgroundConfiguration?.backgroundColor = .systemBackground
            return header
        } else {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SettingsPlainHeader") as? SettingsPlainHeader else {
                return nil
            }
            switch (section) {
            case 1:
                header.setLabel(label: "Payment Methods")
            case 2:
                header.setLabel(label: "Account")
            case 3:
                header.setLabel(label: "Security")
            case 4:
                header.setLabel(label: "")
            default:
                return nil
            }
            header.backgroundConfiguration?.backgroundColor = .systemBackground
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 16 //(32-16) where 16 is the empty view within cell
        case 3:
            return 16 //(32-16) where 16 is the empty view within cell
        case 4:
            return 56
        case 5:
            return 56
        default:
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4 {
            return CGFloat(8) //40 - (footer height + cell empty view)
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension SettingsScreen: SecuritySectionDelegate {
    func showPopUp(message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension SettingsScreen: SignOutBtnDelegate {
    func signOut() {
        //save state (not logged in)
        UserDefaults.standard.set(false, forKey: "LoggedIn")
        
        //reset root 
        let rootVC:SignInSignUpScreen = self.storyboard?.instantiateViewController(withIdentifier: "SignInSignUpScreen") as! SignInSignUpScreen
        let nc = UINavigationController(rootViewController: rootVC)
        nc.viewControllers = [rootVC]
        UIApplication.shared.keyWindow?.rootViewController = nc
    }
}
