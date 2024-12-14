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
    private var news: [ArticleModel] = []
    
    private enum Const {
        static let cornerRadius: CGFloat = 20
        static let pinOffset: Double = 10
        static let heightMultipier: CGFloat = 0.4
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
        interactor?.loadFreshNews(News.LoadFresh.Request())
        configureUI()
    }
    
    func displayFreshNews(_ viewModel: News.LoadFresh.ViewModel) {
        news = viewModel.displayedNews
        tableView.reloadData()
    }
    
    // MARK: - Configuring Methods
    
    private func configureUI() {
        view.backgroundColor = .white
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = Const.cornerRadius
        tableView.pin(to: view, Const.pinOffset)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
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
}
