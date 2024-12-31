//
//  PolygonInformationTableViewCell.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

import UIKit

class PolygonInformationTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var polygonInfoCV: UICollectionView! {
        didSet {
            registerCells()
        }
    }
    
    //MARK: Variables
    var sampleData = [
        PolygonInfoModel(
            title: "What is Polygon?",
            value: "$3 MATIC",
            videoLength: "1"
        ),
        PolygonInfoModel(
            title: "What is Polygon?",
            value: "$3 MATIC",
            videoLength: "1"
        )
    ]
    
    //MARK: Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        polygonInfoCV.delegate = self
        polygonInfoCV.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Helper Functions
    func registerCells() {
        polygonInfoCV.register(UINib(nibName: "PolygonInformationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PolygonInformationCollectionViewCell")
    }
    
    func setCVLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16 // Spacing between columns
        polygonInfoCV.collectionViewLayout = layout
    }
}

//MARK: Collection View Delegates
extension PolygonInformationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  polygonInfoCV.dequeueReusableCell(withReuseIdentifier: "PolygonInformationCollectionViewCell", for: indexPath) as? PolygonInformationCollectionViewCell else {
            return PolygonInformationCollectionViewCell()
        }
        cell.setValues(model: sampleData[indexPath.row])
        return cell
    }
}

extension PolygonInformationTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)*0.89
        return CGSize(width: width, height: 247)
    }
}
