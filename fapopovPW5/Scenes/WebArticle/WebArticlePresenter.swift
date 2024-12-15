//
//  WebArticlePresenter.swift
//  fapopovPW5
//
//  Created by Фома Попов on 15.12.2024.
//

import Foundation
import UIKit

// MARK: - WebArticlePresenter
final class WebArticlePresenter: WebArticlePresentationLogic {
    // MARK: - View
    weak var view: WebArticleViewController?
    
    // MARK: - Methods
    func routeToNews(_ response: Article.ShowNews.Response) {
        if let viewController = view {
            viewController.dismiss(animated: true)
        }
    }
}

