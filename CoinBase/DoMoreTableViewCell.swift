//
//  DoMoreTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

import UIKit

class DoMoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var doMoreCV: UICollectionView! {
        didSet {
            registerCVCells()
            setCVLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doMoreCV.delegate = self
        doMoreCV.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helper Functions
    func registerCVCells() {
        doMoreCV.register(UINib(nibName: "DoMoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DoMoreCollectionViewCell")
    }
    
    func setCVLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16 // Spacing between columns
        doMoreCV.collectionViewLayout = layout
    }
}

extension DoMoreTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  doMoreCV.dequeueReusableCell(withReuseIdentifier: "DoMoreCollectionViewCell", for: indexPath) as? DoMoreCollectionViewCell else {
            return DoMoreCollectionViewCell()
        }
        return cell
    }
}

extension DoMoreTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)*0.89
        return CGSize(width: width, height: 194)
    }
}
