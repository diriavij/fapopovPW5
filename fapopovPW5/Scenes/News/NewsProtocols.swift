//
//  NewsProtocols.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

// MARK: - NewsBusinessLogic
protocol NewsBusinessLogic {
    func loadFreshNews(_ request: News.LoadFresh.Request)
    func loadMoreNews(_ request: News.LoadMore.Request)
    func loadShare(_ request: News.Share.Request)
    func loadArticle(_ request: News.ShowArticle.Request)
}

// MARK: - NewsPresentationLogic
protocol NewsPresentationLogic {
    func presentFreshNews(_ response: News.LoadFresh.Response)
    func presentMoreNews(_ response: News.LoadMore.Response)
    func presentShare(_ response: News.Share.Response)
    func routeToArticle(_ response: News.ShowArticle.Response)
}

// MARK: - NewsDataStore
protocol NewsDataStore {
    var news: [ArticleModel]? {get set}
}
