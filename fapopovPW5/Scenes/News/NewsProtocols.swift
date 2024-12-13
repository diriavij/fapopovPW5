//
//  NewsProtocols.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

// MARK: - NewsBusinessLogic
protocol NewsBusinessLogic {
    func loadFreshNews(_ request: News.Other.Request)
    func loadMoreNews(_ request: News.Other.Request)
}

// MARK: - NewsPresentationLogic
protocol NewsPresentationLogic {
    func presentFreshNews(_ response: News.Other.Response)
    func presentMoreNews(_ response: News.Other.Response)
    
    func routeTo()
}

// MARK: - NewsDataStore
protocol NewsDataStore {
    var news: [ArticleModel]? {get set}
}
