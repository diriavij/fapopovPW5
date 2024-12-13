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
    
    // MARK: - Constants
    
    private enum Const {
        static let cornerRadius: CGFloat = 20
        static let pinOffset: Double = 10
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
    
    func configure() {
        
    }
    
    private func configureUI() {
        configureCell()
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(wrapView)
        
        wrapView.isUserInteractionEnabled = true
        wrapView.backgroundColor = .black
        wrapView.layer.cornerRadius = Const.cornerRadius
        wrapView.pinVertical(to: self, Const.pinOffset)
        wrapView.pinHorizontal(to: self, Const.pinOffset)
    }
}
