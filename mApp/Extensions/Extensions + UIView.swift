//
//  Extensions + UIView.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import UIKit

extension UIView {
    func addBlurEffect() {
        //set blur effect
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        //set vibrancy View
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        //set blur view
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = self.bounds.height/2
        blurView.clipsToBounds = true
        self.insertSubview(blurView, at: 0)
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurView.contentView.addSubview(vibrancyView)
        vibrancyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let optionsView = UIView()
        vibrancyView.contentView.addSubview(optionsView)
        optionsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func addShadow(_ shadowColor: UIColor, _ shadowOpacity: Float) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1) //CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = self.layer.cornerRadius
        self.layer.shadowOpacity = shadowOpacity
    }

    func createGradientLayer(_ colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.drawsAsynchronously = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
}
