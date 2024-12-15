//
//  ArticleCell.swift
//  fapopovPW5
//
//  Created by Фома Попов on 11.12.2024.
//

import Foundation
import UIKit

// MARK: - ArticleCell

final class ArticleCell: UITableViewCell {
    
    static let reuseId: String = "ArticleCell"
    
    // MARK: - UI Elements
    private let wrapView = UIView()
    private let titleLabel = UILabel()
    private let announceLabel = UILabel()
    private let image = UIImageView()
    private var articleUrl: URL?
    private let background = UIView()
    
    // MARK: - Constants
    
    private enum Const {
        static let cornerRadius: CGFloat = 20
        static let pinOffset: Double = 10
        static let backgroundColor: UIColor = .black
        static let textColor: UIColor = .white
        static let titleColor: UIColor = .systemCyan
        static let horizontalOffset: Double = 20
        static let topOffset: Double = 20
        static let numberOfLines = 3
        static let titleFont: UIFont = .systemFont(ofSize: 14, weight: UIFont.Weight(3))
        static let announceFont: UIFont = .systemFont(ofSize: 12)
        static let numberOfAnnounceLines = 4

        static let placeholderImageURL = URL(fileURLWithPath: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuring Methods
    
    func configure(with article: ArticleModel) {
        titleLabel.text = article.title
        announceLabel.text = article.announce
        articleUrl = article.articleUrl
        image.image = loadImage(article.img?.url ?? Const.placeholderImageURL)
    }
    
    private func configureUI() {
        configureCell()
        configureImage()
        configureBackground()
        configureTitle()
        configureAnnounce()
    }
    
    private func configureBackground() {
        wrapView.addSubview(background)
        background.pinTop(to: wrapView.topAnchor)
        background.pinLeft(to: wrapView.leadingAnchor)
        background.pinRight(to: wrapView.trailingAnchor)
        background.pinHeight(to: wrapView, 0.5)
        background.backgroundColor = Const.backgroundColor
        background.alpha = 0.7
        background.layer.cornerRadius = Const.cornerRadius
    }
    
    private func configureAnnounce() {
        addSubview(announceLabel)
        announceLabel.textColor = Const.textColor
        announceLabel.pinHorizontal(to: wrapView, 20)
        announceLabel.pinTop(to: titleLabel.bottomAnchor, 10)
        announceLabel.font = Const.announceFont
        announceLabel.numberOfLines = Const.numberOfAnnounceLines
    }
    
    private func configureImage() {
        wrapView.addSubview(image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.pinTop(to: wrapView.topAnchor)
        image.pinLeft(to: wrapView.leadingAnchor)
        image.pinRight(to: wrapView.trailingAnchor)
        image.pinBottom(to: wrapView.bottomAnchor)
        image.layer.cornerRadius = Const.cornerRadius
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(wrapView)
        
        wrapView.isUserInteractionEnabled = true
        wrapView.backgroundColor = Const.backgroundColor
        wrapView.layer.cornerRadius = Const.cornerRadius
        wrapView.pinVertical(to: self, Const.pinOffset)
        wrapView.pinHorizontal(to: self, Const.pinOffset)
    }
    
    private func configureTitle() {
        addSubview(titleLabel)
        titleLabel.textColor = Const.titleColor
        titleLabel.pinHorizontal(to: wrapView, 20)
        titleLabel.pinTop(to: wrapView.topAnchor, 10)
        titleLabel.font = Const.titleFont
        titleLabel.numberOfLines = Const.numberOfLines
    }
    
    private func loadImage(_ url: URL) -> UIImage? {
        var resultData: Data = Data()
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                print(error ?? "Error")
                semaphore.signal()
                return
            }
            if let data = data {
                resultData = data
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return UIImage(data: resultData)
    }
}
