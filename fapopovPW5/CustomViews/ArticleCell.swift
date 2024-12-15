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
    private let shimmerView = UIView()
    private var gradientLayer: CAGradientLayer?
    
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
        
        static let alpha = 0.7
        static let heightMultiplier = 0.55
        
        static let startPoint = CGPoint(x: 0, y: 0.5)
        static let endPoint = CGPoint(x: 1, y: 0.5)
        static let locations: [NSNumber] = [0.0, 0.5, 1.0]
        
        static let fromValue = [-1.0, -0.5, 0.0]
        static let toValue = [1.0, 1.5, 2.0]
        static let duration = 1.5
        
        static let animationKey = "shimmerAnimation"
        static let keyPath = "locations"
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = shimmerView.bounds
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if window != nil {
            startShimmerAnimation()
        } else {
            gradientLayer?.removeAnimation(forKey: Const.animationKey)
        }
    }
    
    // MARK: - Configuring Methods
    
    func configure(with article: ArticleModel) {
        titleLabel.text = article.title
        announceLabel.text = article.announce
        articleUrl = article.articleUrl
        
        shimmerView.isHidden = false
        image.image = loadImage(article.img?.url ?? Const.placeholderImageURL)
    }
    
    private func configureUI() {
        configureCell()
        configureImage()
        configureShimmer()
        configureBackground()
        configureTitle()
        configureAnnounce()
    }
    
    private func configureShimmer() {
        wrapView.addSubview(shimmerView)
        shimmerView.pin(to: wrapView)
        shimmerView.layer.cornerRadius = Const.cornerRadius
        shimmerView.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.darkGray.cgColor,
            UIColor.lightGray.cgColor,
            UIColor.darkGray.cgColor
        ]
        gradient.locations = Const.locations
        gradient.startPoint = Const.startPoint
        gradient.endPoint = Const.endPoint
        gradient.frame = shimmerView.bounds
        
        shimmerView.layer.addSublayer(gradient)
        self.gradientLayer = gradient
        
        startShimmerAnimation()
    }
    
    private func startShimmerAnimation() {
        guard let gradient = gradientLayer else { return }
        
        let animation = CABasicAnimation(keyPath: Const.keyPath)
        animation.fromValue = Const.fromValue
        animation.toValue = Const.toValue
        animation.duration = Const.duration
        animation.repeatCount = .infinity
        
        gradient.add(animation, forKey: Const.animationKey)
    }
    
    private func configureBackground() {
        wrapView.addSubview(background)
        background.pinTop(to: wrapView.topAnchor)
        background.pinLeft(to: wrapView.leadingAnchor)
        background.pinRight(to: wrapView.trailingAnchor)
        background.pinHeight(to: wrapView, Const.heightMultiplier)
        background.backgroundColor = Const.backgroundColor
        background.alpha = Const.alpha
        background.layer.cornerRadius = Const.cornerRadius
    }
    
    private func configureAnnounce() {
        addSubview(announceLabel)
        announceLabel.textColor = Const.textColor
        announceLabel.pinHorizontal(to: wrapView, Const.horizontalOffset)
        announceLabel.pinTop(to: titleLabel.bottomAnchor, Const.pinOffset)
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
        titleLabel.pinHorizontal(to: wrapView, Const.horizontalOffset)
        titleLabel.pinTop(to: wrapView.topAnchor, Const.pinOffset)
        titleLabel.font = Const.titleFont
        titleLabel.numberOfLines = Const.numberOfLines
    }
    
    private func loadImage(_ url: URL) -> UIImage? {
        let resultData: Data = Data()
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self else { return }
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image.image = loadedImage
                    self.shimmerView.isHidden = true
                }
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return UIImage(data: resultData)
    }
}
