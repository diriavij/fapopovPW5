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
    private let nav = UINavigationBar()
    
    enum Const {
        static let backgroundColor: UIColor = .black
        static let navBarTitle = "Seldon.News"
        static let backButtonText = "Back"
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
        view.backgroundColor = Const.backgroundColor
        configureWebView()
        configureNavigationBar()
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        webView.pinHorizontal(to: view)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        if let url = articleUrl {
            webView.load(URLRequest(url: url))
        }
    }
    
    private func configureNavigationBar() {
        title = Const.navBarTitle
        let backButton = UIBarButtonItem(
            title: Const.backButtonText,
            style: .plain,
            target: self,
            action: #selector(returnToPrevious)
        )
        let shareButton = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareArticle)
        )
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = shareButton
    }
    
    // MARK: - Actions
    
    @objc
    private func returnToPrevious() {
        interactor.loadNews(Article.ShowNews.Request())
    }
    
    @objc
    private func shareArticle() {
        interactor.loadShare(Article.Share.Request(url: articleUrl))
    }
    
}
