//
//  NewsTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsIcon: UIImageView!
    @IBOutlet weak var newsPreview: UILabel!
    
    //MARK: - Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Helper Functions
    func setValues(model: NewsDataModel) {
        let fullText = "Decrypt • \(model.timeElapsed) • \(model.mode)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        //ranges of texts
        let modeText = (fullText as NSString).range(of: model.mode)
        let remainingText = NSRange(location: 0, length: fullText.count)
        //custom gray to entire text
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Custom text gray") as Any, range: remainingText)
        
        //custom blue to mode range
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Custom blue") as Any, range: modeText)
        
        // Set the attributed string to the label
        title.attributedText = attributedString
        
        newsPreview.text = model.articlePreview
        newsIcon.image = UIImage(named: model.newsIcon)
    }
}
