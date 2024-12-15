//
//  ArticleWorker.swift
//  fapopovPW5
//
//  Created by Фома Попов on 14.12.2024.
//

import Foundation

enum ArticleError: Error {
    case invalidURL
    case noData
    case decodingError
    case noNews
}

// MARK: - ArticleWorker
final class ArticleWorker {
    
    private let decoder: JSONDecoder = JSONDecoder()
    private var news: [ArticleModel] = []
    
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
    
    // MARK: - Fetch news
    func fetchNews(_ pageIndex: Int) -> [ArticleModel] {
        guard let url = getURL(4, pageIndex) else { return [] }
        let semaphore = DispatchSemaphore(value: 0)
        var result: [ArticleModel] = []
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let _ = error {
                print(error ?? "Error")
                semaphore.signal()
                return
            }
            
            if
                let self,
                let data = data,
                let newsPage = try? decoder.decode(NewsPage.self, from: data)
            {
                result = newsPage.news ?? []
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return result
    }
    
}
