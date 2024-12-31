//
//  News Data Model.swift
//  CoinBase
//
//  Created by Iman Azher on 30/12/2024.
//

class NewsDataModel {
    var timeElapsed: String
    var mode: String
    var articlePreview: String
    var newsIcon: String
    
    init(timeElapsed: String, mode: String, articlePreview: String, newsIcon: String) {
        self.timeElapsed = timeElapsed
        self.mode = mode
        self.articlePreview = articlePreview
        self.newsIcon = newsIcon
    }
}
