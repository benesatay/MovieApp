//
//  CustomIndicatiorView.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 17.07.2021.
//

import UIKit
import Lottie

class ProcessingView: UIView {

    lazy private var animationView: AnimationView? = nil


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        animationView = .init(name: "movie_loader_image")
        self.addSubview(animationView!)
        animationView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 2
    }
    
    public func startLoading() {
        animationView!.play()
    }

    public func stopLoading() {
        animationView!.stop()
    }
}
