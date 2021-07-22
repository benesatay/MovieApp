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
            }
        }
    }

    override func setupViews() {
        setUI()
    }
    
    private func setUI() {
        //        self.setCellShadow(shadowOpacity: 0.2, shadowRadius: 20)
        self.layer.cornerRadius = 20
        
        self.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let voteBG = setBackgroundView(maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        self.posterImageView.addSubview(voteBG)
        voteBG.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.bottom.equalToSuperview()
        }

        let yearColor = UIColor.white
        yearImageView.image = UIImage(systemName: "calendar")
        yearImageView.contentMode = .scaleAspectFit
        yearImageView.tintColor = yearColor
        voteBG.addSubview(yearImageView)
        yearImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(GAP)
            make.centerY.equalToSuperview()
        }

        yearLabel.styleText(.small12, .iRegular, yearColor, .right)
        voteBG.addSubview(yearLabel)
        yearLabel.snp.makeConstraints { make in
            make.left.equalTo(yearImageView.snp.right).offset(SMALL_GAP)
            make.centerY.equalTo(yearImageView)
            make.right.equalToSuperview().inset(GAP)
        }
    }

    
    private func setBackgroundView(maskedCorners: CACornerMask) -> UIView {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        backgroundView.addBlurEffect()
        backgroundView.alpha = 0.8
        let blurView = backgroundView.subviews[0] as! UIVisualEffectView
        blurView.layer.maskedCorners = maskedCorners
        return backgroundView
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
