//
//  NewsAssembly.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

import UIKit

enum NewsAssembly {
    static func build() -> NewsViewController {
        let presenter = NewsPresenter()
        let interactor = NewsInteractor(presenter: presenter)
        let view = NewsViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
