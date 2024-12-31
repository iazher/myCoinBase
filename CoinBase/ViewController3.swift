//
//  ViewController3.swift
//  CoinBase
//
//  Created by Iman Azher on 10/12/2024.
//

import UIKit

protocol ViewController3Delegate {
    func didUpdateRowData(at index: Int)
}

class ViewController3: UIViewController {
    
    @IBOutlet weak var iconTitle: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var details: UILabel!
    
    var delegate: ViewController3Delegate?
    var index: Int? // To track index of row being updated
    var indexPath: IndexPath?
    
    var titleStr: String = ""
    var imageName: String = ""
    var itemValue: String = ""
    var itemDetail: String = ""
    var itemModel: PortfolioItem?
    
    // passing data using closure
    var returnIndex: ((Int) -> Void)?

    func initModel(model: PortfolioItem) {
        itemModel = model
        setValues(model)
    }
    
    func setValues(_ model: PortfolioItem) {
        titleStr = model.itemName
        imageName = model.iconName
        itemValue = model.itemValue
        itemDetail = model.detail
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        iconTitle.text = titleStr
        iconImage.image = UIImage(named: imageName)
        valueLabel.text = itemValue
        details.text = itemDetail
    }
  
    // MARK: - Action outlets
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeData(_ sender: Any) {
        iconTitle.text = "changed"
        itemModel?.itemName = "changed"
        
        // tells delegate data has changed
        guard let index = index else {
            return
        }
        returnIndex?(index)
    }
}
