//
//  NewsModels.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

import Foundation

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
    
    enum ShowArticle {
        struct Request {
            var article: ArticleModel
        }
        struct Response {
            var articleURL: URL?
        }
        struct ViewModel {

        }
    }
}
