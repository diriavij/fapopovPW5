//
//  NewsModels.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

// MARK: - News
enum News {
    enum LoadFresh {
        struct Request {}
        struct Response {
            var news: [ArticleModel]
        }
        struct ViewModel {
            var displayedNews: [ArticleModel]
        }
    }
}
