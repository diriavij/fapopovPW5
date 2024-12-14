//
//  NewsInteractor.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

import Foundation

// MARK: - NewsInteractor
final class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    
    var news: [ArticleModel]?
    
    private let presenter: NewsPresentationLogic
    
    private let decoder: JSONDecoder = JSONDecoder()
    
    private enum Const {
        static let baseURL = "https://news.myseldon.com/api"
    }
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadFreshNews(_ request: News.LoadFresh.Request) {
        let worker = ArticleWorker()
        let result = worker.fetchNews()
        presenter.presentFreshNews(News.LoadFresh.Response(news: result))
    }
    
    func loadMoreNews(_ request: News.LoadFresh.Request) {
        
    }
    
    
}
