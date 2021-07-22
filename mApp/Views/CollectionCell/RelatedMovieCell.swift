//
//  RelatedMovieCell.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 20.07.2021.
//

import UIKit

class RelatedMovieCell: BaseCollectionCell {
    
    lazy private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy private var nameLabel = CustomLabel()


    public var data: SearchResponse? {
        didSet {
            if let data = data {
                if let urlStr = data.poster, let posterURL = URL(string: urlStr) {
                    posterImageView.kf.setImage(with: posterURL)
                    if urlStr == "N/A" {
                        self.posterBorderWidth(0.3)
                    } else {
                        self.posterBorderWidth(0)
                    }
                }
                self.nameLabel.text = data.title
            }
        }
    }

    override func setupViews() {
        setUI()
    }
    
    private func setUI() {
//        self.addShadow(.black, 0.1)
        self.layer.cornerRadius = 15
        
        self.addSubview(posterImageView)
        posterImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        posterImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
         
        nameLabel.styleText(.large26, .iSemibold, .lightText, .center)
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(SMALL_GAP)
            make.left.right.equalTo(posterImageView)
            make.bottom.equalToSuperview()
        }
    }
    
    private func posterBorderWidth(_ borderWidth: CGFloat) {
        posterImageView.layer.borderWidth = borderWidth
    }

}
