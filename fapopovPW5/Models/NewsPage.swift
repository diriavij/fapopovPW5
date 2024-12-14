//
//  NewsPage.swift
//  fapopovPW5
//
//  Created by Фома Попов on 13.12.2024.
//

import Foundation

// MARK: - NewsPage

struct NewsPage: Decodable {
    var news: [ArticleModel]?
    var requestId: String?
    
    enum CodingKeys: String, CodingKey {
        case news
        case requestId
    }
    
    // MARK: - Lifecycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requestId = try container.decodeIfPresent(String.self, forKey: .requestId)
        
        if var newsItems = try container.decodeIfPresent([ArticleModel].self, forKey: .news) {
            newsItems = newsItems.map { var article = $0; article.requestId = self.requestId; return article }
            self.news = newsItems
        } else {
            self.news = nil
        }
    }
}
