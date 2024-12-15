//
//  ViewController.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

import UIKit

// MARK: - NewsViewController
final class NewsViewController: UIViewController {
    
    // MARK: - Variables and Constants
    
    private var interactor: (NewsBusinessLogic & NewsDataStore)?
    private let tableView = UITableView(frame: .zero)
    private let refreshControl = UIRefreshControl()
    private var news: [ArticleModel] = []
    private var currentIndex = 1
    
    private var isLoadingFresh = false
    private var isLoadingMore = false
    private var loadMoreTimer: Timer?
    
    private enum Const {
        static let cornerRadius: CGFloat = 20
        static let pinOffset: Double = 10
        static let heightMultipier: CGFloat = 0.4
        static let backgroundColor: UIColor = .black
        static let actionColor: UIColor = .systemCyan
        static let actionText = "Share"
        static let threshold = 100.0
        static let timeInterval = 0.1
    }
    
    // MARK: - Lifecycle
    
    init(interactor: NewsInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFreshNews()
        configureUI()
    }
    
    func displayFreshNews(_ viewModel: News.LoadFresh.ViewModel) {
        isLoadingFresh = false
        news = viewModel.displayedNews
        tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func displayMoreNews(_ viewModel: News.LoadMore.ViewModel) {
        isLoadingMore = false
        news.append(contentsOf: viewModel.displayedNews)
        tableView.reloadData()
    }
    
    // MARK: - Configuring Methods
    
    private func configureUI() {
        configureTable()
        configureRefreshControl()
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.backgroundColor = Const.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = Const.cornerRadius
        tableView.pin(to: view, Const.pinOffset)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadFreshNews), for: .valueChanged)
        refreshControl.tintColor = Const.actionColor
    }
    
    // MARK: - Actions
    
    private func handleShare(_ articleUrl: URL?) {
        interactor?.loadShare(News.Share.Request(url: articleUrl))
    }
    
    @objc
    private func loadFreshNews() {
        guard !isLoadingFresh else { return }
        isLoadingFresh = true
        if let refreshControl = tableView.refreshControl, !refreshControl.isRefreshing {
            DispatchQueue.main.async {
                refreshControl.beginRefreshing()
                let offsetPoint = CGPoint(x: 0, y: -refreshControl.frame.height)
                self.tableView.setContentOffset(offsetPoint, animated: true)
            }
        }
        interactor?.loadFreshNews(News.LoadFresh.Request())
    }
    
    private func loadMoreNews() {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        if currentIndex <= 10 {
            currentIndex += 1
            interactor?.loadMoreNews(News.LoadMore.Request(pageIndex: currentIndex))
        }
    }
    
    private func debounceLoadMoreNews() {
        loadMoreTimer?.invalidate()
        loadMoreTimer = Timer.scheduledTimer(withTimeInterval: Const.timeInterval, repeats: false) { [weak self] _ in
            self?.loadMoreNews()
        }
    }
}

// MARK: - Extensions

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * Const.heightMultipier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ArticleCell.reuseId,
            for: indexPath
        )
        
        guard let articleCell = cell as? ArticleCell else { return cell }
        
        articleCell.configure(with: news[indexPath.row])
       
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.loadArticle(News.ShowArticle.Request(article: news[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: Const.actionText) { [weak self] (action, view, completionHandler) in
            self?.handleShare(self?.news[indexPath.row].articleUrl)
            completionHandler(true)
        }
        action.backgroundColor = Const.actionColor
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height - Const.threshold {
            debounceLoadMoreNews()
        }
    }
}

