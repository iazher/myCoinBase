//
//  TopMoversTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 25/12/2024.
//

import UIKit

class TopMoversTableViewCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var topMoversCV: UICollectionView! {
        didSet {
            registerCVCells()
            setCVLayout()
        }
    }
    
    //MARK: - Variables
    var topMoversData = [
        TopMoversDataModel(
            iconName: "KNCL - KNC Legacy",
            title: "KNC",
            amount: "$2.66",
            increase: "+22.37%"
        ),
        TopMoversDataModel(
            iconName: "ATOM - Cosmos Token",
            title: "ATOM",
            amount: "$16.39",
            increase: "+16.07%"
        ),
        TopMoversDataModel(
            iconName: "aCRV - Aave CRV",
            title: "CRV",
            amount: "$10.15",
            increase: "+6.50%"
        )
    ]
    //MARK: - Lifecycle Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topMoversCV.delegate = self
        topMoversCV.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helper Functions
    func registerCVCells() {
        topMoversCV.register(UINib(nibName: "TopMoversCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopMoversCollectionViewCell")
    }
    
    func setCVLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16 // Spacing between columns
        topMoversCV.collectionViewLayout = layout
    }
}

//MARK: - CollectionView Delegates

extension TopMoversTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topMoversData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  topMoversCV.dequeueReusableCell(withReuseIdentifier: "TopMoversCollectionViewCell", for: indexPath) as? TopMoversCollectionViewCell else {
                return TopMoversCollectionViewCell()
        }
        cell.setValues(model: topMoversData[indexPath.row])
        return cell
    }
}

extension TopMoversTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)*(138/352)
        return CGSize(width: width, height: 145)
    }
}
