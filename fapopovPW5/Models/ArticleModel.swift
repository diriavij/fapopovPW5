//
//  ArticleModel.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

import Foundation

// MARK: - ArticleModel

struct ArticleModel: Decodable {
    var newsId: Int?
    var title: String?
    var announce: String?
    var img: ImageContainer?
    var requestId: String?
    var articleUrl: URL? {
        let requestId = requestId ?? ""
        let newsId = newsId ?? 0
        return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
    }
}
