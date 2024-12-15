//
//  WebArticleAssembly.swift
//  fapopovPW5
//
//  Created by Фома Попов on 15.12.2024.
//

import Foundation

// MARK: - WebArticleAssembly
enum WebArticleAssembly {
    static func build() -> WebArticleViewController {
        let presenter = WebArticlePresenter()
        let interactor = WebArticleInteractor(presenter: presenter)
        let view = WebArticleViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
