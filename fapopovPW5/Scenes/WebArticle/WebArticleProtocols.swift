//
//  WebArticleProtocols.swift
//  fapopovPW5
//
//  Created by Фома Попов on 15.12.2024.
//

// MARK: - WebArticleBusinessLogic
protocol WebArticleBusinessLogic {
    func loadNews(_ request: Article.ShowNews.Request)
}

// MARK: - WebArticlePresentationLogic
protocol WebArticlePresentationLogic {
    func routeToNews(_ response: Article.ShowNews.Response)
}
