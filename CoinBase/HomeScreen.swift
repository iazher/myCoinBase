//
//  HomeScreen.swift
//  CoinBase
//
//  Created by Iman Azher on 24/12/2024.
//

import UIKit

class HomeScreen: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var homeTableView: UITableView! {
        didSet {
            tableViewRegistrations()
            homeTableView.separatorStyle = .none
            homeTableView.allowsSelection = false
            homeTableView.sectionHeaderTopPadding = 0
            homeTableView.showsVerticalScrollIndicator = false
        }
    }
    
    //MARK: - Variables
    let customGray = UIColor(red: 112/235, green: 112/235, blue: 112/235, alpha: 1)
    
    let watchListData = [WatchListModel(
        title: "Bitcoin",
        abbreviation: "BTC",
        iconName: "BTC - Bitcoin",
        amount: "$38,650.31",
        increase: "+3.88%"
    )]
    
    let newsData = [
        NewsDataModel(
            timeElapsed: "18 hours ago",
            mode: "USD Coin",
            articlePreview: "Miami Crypto Aspirations Boosted by Borderless Capital's $25 Million Fund",
            newsIcon: "News Icon 1"
        ),
        NewsDataModel(
            timeElapsed: "19 hours ago",
            mode: "Bitcoin",
            articlePreview: "Bitcoin Mini Showdown Puts New York on Front Lines of a Green Fight",
            newsIcon: "News Icon 2"
        ),
        NewsDataModel(
            timeElapsed: "20 hours ago",
            mode: "Bitcoin",
            articlePreview: "Bitcoin Price Volatility Reached Its Highest In A Year During May",
            newsIcon: "News Icon 3"
        ),
        NewsDataModel(
            timeElapsed: "21 hours ago",
            mode: "Bitcoin",
            articlePreview: "Guggenheim’s New Fund May Seek Bitcoin Exposure",
            newsIcon: "News Icon 4"
        ),
        NewsDataModel(
            timeElapsed: "21 hours ago",
            mode: "USD Coin",
            articlePreview: "Standard Chartered to Launch Institutional Crypto Brokerage and Exchange in Europe",
            newsIcon: "News Icon 5"
        )
    ]
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    // MARK: - Helper Functions
    func tableViewRegistrations() {
        homeTableView.register(UINib(nibName: "WelcomeTableViewCell", bundle: nil), forCellReuseIdentifier: "WelcomeTableViewCell")
        homeTableView.register(UINib(nibName: "WatchListTableViewCell", bundle: nil), forCellReuseIdentifier: "WatchListTableViewCell")
        homeTableView.register(UINib(nibName: "TopMoversTableViewCell", bundle: nil), forCellReuseIdentifier: "TopMoversTableViewCell")
        homeTableView.register(UINib(nibName: "LearnAboutPolygonTableViewCell", bundle: nil), forCellReuseIdentifier: "LearnAboutPolygonTableViewCell")
        homeTableView.register(UINib(nibName: "PolygonInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "PolygonInformationTableViewCell")
        homeTableView.register(UINib(nibName: "RewardsTableViewCell", bundle: nil), forCellReuseIdentifier: "RewardsTableViewCell")
        homeTableView.register(UINib(nibName: "DoMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "DoMoreTableViewCell")
        homeTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        
        //custom headers
        homeTableView.register(UINib(nibName: "CustomSectionHeaderTV", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomSectionHeaderTV")
    }
}

//MARK: - TableView Delegates
extension HomeScreen: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: //welcome to coinbase
            return 1
        case 1: //WatchList
            return watchListData.count
        case 2: //Top Movers
            return 1
        case 3: //Learn about polygon
            return 1
        case 4: //Polygon information
            return 1
        case 5: //Rewards
            return 1
        case 6: //Do More
            return 1
        case 7: //News
            return newsData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeTableViewCell", for: indexPath) as? WelcomeTableViewCell else {
                    return WelcomeTableViewCell()
            }
            return cell
        case 1:
            print("section 1")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as? WatchListTableViewCell else {
                    return WatchListTableViewCell()
            }
            cell.setViewBorders()
            cell.setValues(model: watchListData[indexPath.row])
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopMoversTableViewCell", for: indexPath) as? TopMoversTableViewCell else {
                return TopMoversTableViewCell()
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LearnAboutPolygonTableViewCell", for: indexPath) as? LearnAboutPolygonTableViewCell else {
                return LearnAboutPolygonTableViewCell()
            }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PolygonInformationTableViewCell", for: indexPath) as? PolygonInformationTableViewCell else {
                return PolygonInformationTableViewCell()
            }
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTableViewCell", for: indexPath) as? RewardsTableViewCell else {
                return RewardsTableViewCell()
            }
            return cell
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoMoreTableViewCell", for: indexPath) as? DoMoreTableViewCell else {
                return DoMoreTableViewCell()
            }
            return cell
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
                return NewsTableViewCell()
            }
            cell.setValues(model: newsData[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomSectionHeaderTV") as? CustomSectionHeaderTV else {
            return nil
        }
        
        //default header settings
        header.headerLabelRight.text = ""
        header.headerLabel.textColor = UIColor(named: "Custom black")
        header.headerLabel.font = UIFont(name: "Helvetica Bold", size: 22)
        
        switch (section) {
        case 1:
            header.headerLabel.text = "WatchList"
        case 2:
            header.headerLabel.text = "Top Movers"
        case 3:
            header.headerLabel.text = "Learn about Polygon"
        case 4:
            header.headerLabel.text = "Building an internet of blockchains"
            header.headerLabel.font = UIFont(name: "Helvetica", size: 18)
            header.headerLabel.textColor = customGray
        case 5:
            header.headerLabel.text = "Rewards"
            header.headerLabel.font = UIFont(name: "Helvetica Bold", size: 20)
        case 6:
            header.headerLabel.text = "Do more with crypto"
            header.headerLabel.textColor = UIColor(named: "Custom black")
            header.headerLabel.font = UIFont(name: "Helvetica Bold", size: 20)
        case 7:
            header.headerLabel.text = "News"
            header.headerLabelRight.text = "View more"
            header.headerLabelRight.textColor = UIColor(named: "Custom blue")
        default:
            return nil
        }
        header.backgroundConfiguration?.backgroundColor = .systemBackground
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 7 {
            return 56
        }
        return 32
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            return 430
        case 1:
            return 74
        case 2:
            return 145
        case 3:
            return 42
        case 4:
            return 247
        case 5:
            return 189
        case 6:
            return 194
        case 7:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
}
