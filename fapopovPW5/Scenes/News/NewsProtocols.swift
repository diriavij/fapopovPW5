//
//  NewsProtocols.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

// MARK: - NewsBusinessLogic
protocol NewsBusinessLogic {
    func loadFreshNews(_ request: News.LoadFresh.Request)
    func loadMoreNews(_ request: News.LoadFresh.Request)
}

// MARK: - NewsPresentationLogic
protocol NewsPresentationLogic {
    func presentFreshNews(_ response: News.LoadFresh.Response)
    func presentMoreNews(_ response: News.LoadFresh.Response)
    
    func routeTo()
}

// MARK: - NewsDataStore
protocol NewsDataStore {
    var news: [ArticleModel]? {get set}
}
