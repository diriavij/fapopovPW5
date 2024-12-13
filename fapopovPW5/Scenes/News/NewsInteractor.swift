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
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadFreshNews(_ request: News.Other.Request) {
        
    }
    
    func loadMoreNews(_ request: News.Other.Request) {
        
    }
    
    
}
