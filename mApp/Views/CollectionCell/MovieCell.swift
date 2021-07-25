//
//  MovieCell.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
    }
}

class MovieCell: BaseCollectionCell {
    
    lazy private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy private var titleLabel = CustomLabel()
    lazy private var nameLabel = CustomLabel()

    lazy private var yearLabel = CustomLabel()
    lazy private var yearImageView = UIImageView()

    public var data: SearchResponse? {
        didSet {
            if let data = data {
                if let urlStr = data.poster, let posterURL = URL(string: urlStr) {
                    posterImageView.kf.setImage(with: posterURL)
                    if urlStr == "N/A" {
                        posterImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
                        posterImageView.layer.borderWidth = 0.3
                        self.createNameLabel(data.title)
                    } else {
                        self.removeNameLabel()
                        posterImageView.layer.borderWidth = 0
                    }
                }
                yearLabel.text = data.year
                titleLabel.text = data.title
            }
        }
    }

    override func setupViews() {
        setUI()
    }
    
    private func setUI() {
        self.addShadow(.white, 0.3)
        self.layer.cornerRadius = 20
        
        self.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        yearLabel.styleText(.small12, .iSemibold, .white, .center)
        yearLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        yearLabel.layer.cornerRadius = self.layer.cornerRadius
        yearLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        yearLabel.edgeInsets = UIEdgeInsets(top: GAP, left: GAP, bottom: GAP, right: GAP)

        self.posterImageView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
        }
        
        titleLabel.edgeInsets = UIEdgeInsets(top: GAP, left: GAP, bottom: GAP, right: GAP)
        titleLabel.styleText(.small12, .iSemibold, .white, .center)
        titleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        titleLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        self.posterImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func createNameLabel(_ name: String?) {
        nameLabel.text = name
        nameLabel.styleText(.large26, .iSemibold, .lightText, .center)
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.right.lessThanOrEqualToSuperview().inset(SMALL_GAP)
            make.center.equalToSuperview()
        }
    }
    
    private func removeNameLabel() {
        nameLabel.removeFromSuperview()
    }
}
