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
    
    func presentMoreNews(_ response: News.LoadFresh.Response) {
        
    }
    
    func routeTo() {
        
    }
}
