//
//  NewsPresenter.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

import Foundation
import UIKit

// MARK: - NewsPresenter
final class NewsPresenter: NewsPresentationLogic {
    weak var view: NewsViewController?
    
    // MARK: - Methods
    func presentFreshNews(_ response: News.LoadFresh.Response) {
        view?.displayFreshNews(News.LoadFresh.ViewModel(displayedNews: response.news))
    }
    
    func presentMoreNews(_ response: News.LoadMore.Response) {
        view?.displayMoreNews(News.LoadMore.ViewModel(displayedNews: response.news))
    }
    
    func presentShare(_ response: News.Share.Response) {
        let urlToShare = [response.url]
        let activityViewController = UIActivityViewController(activityItems: urlToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view?.view
        view?.present(activityViewController, animated: true)
    }
    
    func routeToArticle(_ response: News.ShowArticle.Response) {
        let articleViewController = WebArticleAssembly.build()
        articleViewController.articleUrl = response.articleURL
        let navController = UINavigationController(rootViewController: articleViewController)
        navController.modalPresentationStyle = .fullScreen
        view?.present(navController, animated: true)
    }
}
