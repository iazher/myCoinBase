//
//  TwoStepVerification.swift
//  CoinBase
//
//  Created by Iman Azher on 23/12/2024.
//

import UIKit
import Foundation

class TwoStepVerification: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var countryCode: UILabel!

    @IBOutlet weak var phoneTextField: UITextField! {
        didSet {
            setTextFieldBorders(textField: phoneTextField)
            addPadding()
        }
    }
    
    @IBOutlet weak var continueBtn: UIButton! {
        didSet {
            continueBtn.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var textFieldContainer: UIView! {
        didSet {
            textFieldContainer.layer.borderColor = customGray.cgColor
            textFieldContainer.layer.borderWidth = 1
            textFieldContainer.layer.cornerRadius = 4
            textFieldContainer.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var pullDownBtn: UIButton!
    
    @IBOutlet weak var tableViewContainer: UIView! {
        didSet {
            tableViewContainer.layer.borderColor = customGray.cgColor
            tableViewContainer.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var countryCodesTableView: UITableView!
    
    //MARK: - Variables
    let countryCodes: [CountryCodesModel] = [
        CountryCodesModel(countryName: "United States", countryCode: "+1"),
        CountryCodesModel(countryName: "United Kingdom", countryCode: "+44"),
        CountryCodesModel(countryName: "Canada", countryCode: "+1"),
        CountryCodesModel(countryName: "Australia", countryCode: "+61"),
        CountryCodesModel(countryName: "Pakistan", countryCode: "+92"),
        CountryCodesModel(countryName: "Germany", countryCode: "+49"),
        CountryCodesModel(countryName: "France", countryCode: "+33"),
        CountryCodesModel(countryName: "Singapore", countryCode: "+65"),
        CountryCodesModel(countryName: "China", countryCode: "+86"),
        CountryCodesModel(countryName: "Japan", countryCode: "+81")
    ]
    
    let customGray =  UIColor(red: 207/235, green: 207/235, blue: 207/235, alpha: 1)
    let customBlue = UIColor(red: 39/255, green: 82/255, blue: 231/255, alpha: 1)
    let customBlack = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.delegate = self
        countryCodesTableView.delegate = self
        countryCodesTableView.dataSource = self
        registerTableViewCell()
    }
    
    //MARK: - IB Actions
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pullDownBtnTapped(_ sender: UIButton) {
        togglePullDown()
    }
    
    @IBAction func phoneEditingBegin(_ sender: UITextField) {
        phoneLabel.textColor = customBlue
        sender.layer.borderColor = customBlue.cgColor
        sender.layer.borderWidth = 3
        sender.layer.cornerRadius = 4
        sender.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    @IBAction func continueBtnTapped(_ sender: UIButton) {
        navigateToScreen("2StepVerificationScreen2")
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
    
    func addPadding () {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: phoneTextField.frame.height))
            phoneTextField.leftView = leftPaddingView
            phoneTextField.leftViewMode = .always
    }
    
    func registerTableViewCell() {
        countryCodesTableView.register(UINib(nibName: "CountryCodesTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryCodesTableViewCell")
    }
    
    func togglePullDown() {
        if tableViewContainer.isHidden {
            tableViewContainer.isHidden = false
            self.view.bringSubviewToFront(tableViewContainer)
        } else {
            tableViewContainer.isHidden = true
        }
    }
}

//MARK: - Text Field Delegates
extension TwoStepVerification: UITextFieldDelegate {
    // condition for user input:
    // 1. Numbers only
    // 2. 10 characters only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == "" {
                return true
            }
        if textField == phoneTextField{
            let charAfterUse = textField.text!.count + 1
            var isNumber = false
            if let _ = Int(string) {
                isNumber = true
            }
            if (charAfterUse > 10) || (string == " ") || (isNumber == false) {
                    return false
                }
            }
            return true
    }
}

//MARK: - Table View Delegates
extension TwoStepVerification: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCodesTableViewCell", for: indexPath) as? CountryCodesTableViewCell else {
                return CountryCodesTableViewCell()
        }
        let currentData = countryCodes[indexPath.row]
        cell.setValues(model: currentData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userSelectedCode = countryCodes[indexPath.row].countryCode
        countryCode.text = userSelectedCode
        togglePullDown()
    }
}
