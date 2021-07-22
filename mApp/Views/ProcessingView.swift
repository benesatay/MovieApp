////
////  CustomIndicatiorView.swift
////  mApp
////
////  Created by Bahadır Enes Atay on 17.07.2021.
////
//
//import UIKit
//import Lottie
//
//class ProcessingView: UIView {
////    lazy private var animationView = AnimationView(name: "image.json")
//    lazy private var customLoadingView = UIView()
//
//    private var viewSize: CGFloat = 100
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupViews() {
////        animationView.contentMode = .scaleAspectFit
////        animationView.loopMode = .loop
////        animationView.animationSpeed = 0.5
////        self.addSubview(animationView)
////        animationView.snp.makeConstraints { make in
////            make.edges.equalToSuperview()
////        }
//        test()
//    }
//    
//    private func test() {
//        customLoadingView.backgroundColor = .systemOrange
//        self.addSubview(customLoadingView)
//        customLoadingView.snp.makeConstraints { make in
//            make.size.equalTo(viewSize)
//            make.edges.equalToSuperview()
//        }
//        customLoadingView.isHidden = true
//        customLoadingView.layer.cornerRadius = viewSize/2
//    }
//
//    public func startLoading() {
//        customLoadingView.isHidden = false
//        customLoadingView.snp.updateConstraints { make in
//            if customLoadingView.bounds.size == .zero {
//                make.size.equalTo(viewSize)
//            } else {
//                make.size.equalTo(0)
//            }
//        }
//        UIView.animate(withDuration: 1) {
//            self.customLoadingView.layer.cornerRadius = 0
//            self.layoutIfNeeded()
//        }
////        animationView.play()
//    }
//    
//    private func initializeLoading() {
//        customLoadingView.snp.updateConstraints { make in
//            make.size.equalTo(viewSize)
//        }
//        customLoadingView.layer.cornerRadius = viewSize/2
//    }
//    
//    public func stopLoading() {
//        customLoadingView.isHidden = true
//        customLoadingView.snp.updateConstraints { make in
//            make.size.equalTo(viewSize)
//        }
////        animationView.stop()
//    }
//}
