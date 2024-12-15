//
//  WebArticleModels.swift
//  fapopovPW5
//
//  Created by Фома Попов on 15.12.2024.
//

import Foundation

enum Article {
    enum ShowNews {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
    
    enum Share {
        struct Request {
            var url: URL?
        }
        struct Response {
            var url: URL?
        }
        struct ViewModel {}
    }
}
