//
//  WebArticleInteractor.swift
//  fapopovPW5
//
//  Created by Фома Попов on 15.12.2024.
//

import Foundation

// MARK: - WebArticleInteractor
final class WebArticleInteractor: WebArticleBusinessLogic {
    // MARK: - Presenter
    private let presenter: WebArticlePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: WebArticlePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadNews(_ request: Article.ShowNews.Request) {
        presenter.routeToNews(Article.ShowNews.Response())
    }
}
