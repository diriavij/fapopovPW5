//
//  WebArticleViewController.swift
//  fapopovPW5
//
//  Created by Фома Попов on 15.12.2024.
//

import Foundation
import WebKit
import UIKit

// MARK: - WebArticleViewController
final class WebArticleViewController: UIViewController {
    
    // MARK: - Variables and Constants
    private var interactor: WebArticleBusinessLogic
    var articleUrl: URL?
    
    private let webView: WKWebView = WKWebView()
    private let returnButton: UIButton = UIButton(type: .system)
    
    enum Const {
        static let buttonText = "Return"
        static let buttonFont: UIFont = .systemFont(ofSize: 18, weight: UIFont.Weight(3))
        static let cornerRadius: CGFloat = 20
    }
    
    // MARK: - Lifecycle
    init(interactor: WebArticleInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configuring Methods
    
    private func configureUI() {
        view.addSubview(webView)
        webView.pinHorizontal(to: view)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 50)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        if let url = articleUrl {
            webView.load(URLRequest(url: url))
        }
        view.backgroundColor = webView.themeColor
        
        view.addSubview(returnButton)
        returnButton.addTarget(self, action: #selector(returnToNews), for: .touchUpInside)
        returnButton.setTitle(Const.buttonText, for: .normal)
        returnButton.setTitleColor(.black, for: .normal)
        returnButton.layer.cornerRadius = Const.cornerRadius
        returnButton.pinCenterX(to: view.centerXAnchor)
        returnButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        returnButton.setHeight(40)
        returnButton.setWidth(100)
        returnButton.backgroundColor = .white
        returnButton.titleLabel?.textColor = .black
        view.bringSubviewToFront(returnButton)
    }
    
    @objc
    private func returnToNews() {
        interactor.loadNews(Article.ShowNews.Request())
    }
}
