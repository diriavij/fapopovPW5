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
    
    // MARK: - Constants
    
    private enum Const {
        static let cornerRadius: CGFloat = 20
        static let pinOffset: Double = 10
        static let backgroundColor: UIColor = .lightGray
        static let textColor: UIColor = .black
        static let horizontalOffset: Double = 20
        static let topOffset: Double = 20
        static let numberOfLines = 3
        static let titleFont: UIFont = .systemFont(ofSize: 18, weight: UIFont.Weight(3))
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
        //image.image = article.img?.url
    }
    
    private func configureUI() {
        configureCell()
        configureTitle()
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
        titleLabel.textColor = Const.textColor
        titleLabel.pinHorizontal(to: wrapView, Const.horizontalOffset)
        titleLabel.pinTop(to: wrapView, Const.topOffset)
        titleLabel.font = Const.titleFont
        titleLabel.numberOfLines = Const.numberOfLines
    }
}
