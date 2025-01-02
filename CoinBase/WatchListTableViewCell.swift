//
//  WatchListTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 24/12/2024.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var cellBorders: UIView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abbreviation: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var increase: UILabel!
    
    //update constraints through these outlets for "Settings" screen
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var innerViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var spacerHeight: NSLayoutConstraint!
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Helper Functions
    func setValues(model: WatchListModel) {
        title.text = model.title
        abbreviation.text = model.abbreviation
        imageIcon.image = UIImage(named: model.iconName)
        amount.text = model.amount
        increase.text = model.increase
    }
    
    func setViewBorders() {
        cellBorders.layer.cornerRadius = 10
        cellBorders.layer.borderColor = UIColor(named: "Border custom gray")?.cgColor
        cellBorders.layer.borderWidth = 1
    }
    
    func updateCellConstraints() {
        self.leadingConstraint.constant = 0
        self.trailingConstraint.constant = 0
        self.topConstraint.constant = 3
        self.innerViewTrailing.constant = 0
        self.spacerHeight.constant = 27
    }
}
