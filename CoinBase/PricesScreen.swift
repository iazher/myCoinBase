//
//  SettingsScreen.swift
//  CoinBase
//
//  Created by Iman Azher on 31/12/2024.
//

import UIKit

class PricesScreen: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var filtersCV: UICollectionView! {
        didSet {
            filtersCV.register(UINib(nibName: "ItemsFiltersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemsFiltersCollectionViewCell")
            filtersCV.allowsSelection = true
        }
    }
    
    @IBOutlet weak var itemsTV: UITableView! {
        didSet {
            itemsTV.register(UINib(nibName: "WatchListTableViewCell", bundle: nil), forCellReuseIdentifier: "WatchListTableViewCell")
            itemsTV.separatorStyle = .none
            itemsTV.showsVerticalScrollIndicator = false
        }
    }
    
    //MARK: - Variables
    //default setting of filters
    var isAssets = true
    var isTradable = false
    var isGainers = false
    var isLosers = false
    
    var filters = ["All assets", "Tradable", "Gainers", "Losers"]
    
    let items = [
        WatchListModel(
            title: "Bitcoin",
            abbreviation: "BTC • Tradable",
            iconName: "BTC - Bitcoin",
            amount: "$36,701.78",
            increase: "-6.28%"
        ),
        WatchListModel(
            title: "Bitcoin Cash",
            abbreviation: "BCH • Tradable",
            iconName: "bch",
            amount: "$665.25",
            increase: "-9.2%"
        ),
        WatchListModel(
            title: "Ethereum",
            abbreviation: "ETH",
            iconName: "ETH - Ethereum Token",
            amount: "$2,629.70",
            increase: "-8.12%"
        ),
        WatchListModel(
            title: "Ethereum Classic",
            abbreviation: "ETC",
            iconName: "ETC - Binance-Peg Ethereum Classic",
            amount: "$63.94",
            increase: "-9.56%"
        ),
        WatchListModel(
            title: "Litecoin",
            abbreviation: "LTC",
            iconName: "LTC - Litecoin Token",
            amount: "$175.76",
            increase: "-10.01%"
        ),
        WatchListModel(
            title: "0x",
            abbreviation: "BCH",
            iconName: "ic-ox",
            amount: "$1.07",
            increase: "-10.75%"
        ),
        WatchListModel(
            title: "Basic Attention Token",
            abbreviation: "BAT",
            iconName: "BAT - Basic Attention Token",
            amount: "$0.75",
            increase: "-10.35%"
        ),
        WatchListModel(
            title: "0x",
            abbreviation: "BCH",
            iconName: "ic-ox",
            amount: "$1.07",
            increase: "+10.75%"
        ),
        WatchListModel(
            title: "Basic Attention Token",
            abbreviation: "BAT",
            iconName: "BAT - Basic Attention Token",
            amount: "$0.75",
            increase: "+10.35%"
        )
    ]
    
    var gainers: [WatchListModel] = []
    var losers: [WatchListModel] = []
    var tradableItems: [WatchListModel] = []
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        filtersCV.delegate = self
        filtersCV.dataSource = self
        
        itemsTV.delegate = self
        itemsTV.dataSource = self
        
        gainers = filterGains(from: items)
        losers = filterLosses(from: items)
        tradableItems = filterTradableItems(from: items)
    }
    
    //MARK: - Helper Functions
    func filterGains(from watchList: [WatchListModel]) -> [WatchListModel] {
        return watchList.filter { $0.increase.contains("+") }
    }

    func filterLosses(from watchList: [WatchListModel]) -> [WatchListModel] {
        return watchList.filter { $0.increase.contains("-") }
    }
    
    func filterTradableItems(from watchList: [WatchListModel]) -> [WatchListModel] {
        return watchList.filter { $0.abbreviation.contains("Tradable") }
    }
}

//MARK: - Collection View Delegates
extension PricesScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  filtersCV.dequeueReusableCell(withReuseIdentifier: "ItemsFiltersCollectionViewCell", for: indexPath) as? ItemsFiltersCollectionViewCell else {
            return ItemsFiltersCollectionViewCell()
        }
        cell.setFilterName(name: filters[indexPath.row])
        
        //initial setting of the filters
        if indexPath.row == 0 {
            cell.setSelectedState()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Reset all other cells to their default state
        let filtersCount = collectionView.numberOfItems(inSection: 0)
        for index in 0..<filtersCount {
            if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? ItemsFiltersCollectionViewCell {
                cell.resetState()
            }
        }
        // Update the selected cell
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? ItemsFiltersCollectionViewCell {
                selectedCell.setSelectedState()
        }
        
        switch (indexPath.row) {
        case 0:
            if isAssets {
                return
            }
            isAssets = true
            isTradable = false; isLosers = false; isGainers = false
        case 1:
            if isTradable {
                return
            }
            isTradable = true
            isAssets = false; isLosers = false; isGainers = false
        case 2:
            if isGainers {
                return
            }
            isGainers = true
            isAssets = false; isTradable = false; isLosers = false
        case 3:
            if isLosers {
                return
            }
            isLosers = true
            isAssets = false; isTradable = false; isGainers = false
        default:
            print("no row")
        }
        itemsTV.reloadData()
    }
}

//MARK: - Table View Delegates
extension PricesScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if isAssets {
            count = items.count
        } else if isTradable {
            count = tradableItems.count
        } else if isGainers {
            count = gainers.count
        } else if isLosers {
            count = losers.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as? WatchListTableViewCell else {
                return WatchListTableViewCell()
        }
        cell.updateCellConstraints()
        cell.layoutIfNeeded()
        
        if isAssets {
            cell.setValues(model: items[indexPath.row])
        } else if isTradable {
            cell.setValues(model: tradableItems[indexPath.row])
        } else if isGainers {
            cell.setValues(model: gainers[indexPath.row])
        } else if isLosers {
            cell.setValues(model: losers[indexPath.row])
        }
        return cell
    }
}
