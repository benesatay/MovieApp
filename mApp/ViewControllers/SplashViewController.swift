//
//  SplashViewController.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 17.07.2021.
//

import UIKit

class SplashViewController: BaseViewController {
    
    lazy private var label = CustomLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkInternetConnection {
            NetworkManager.shared.cancelMonitoring()
        }
    }
    
    //MARK: - NETWORK MANAGER & FIREBASE CONFIG MANAGER
    
    private func checkInternetConnection(completion: () -> ()) {
        NetworkManager.shared.checkInternetConnection {
            self.setUI()
            ConfigManager.shared.setRemoteConfigDefault()
            ConfigManager.shared.getRemoteConfigValue { text in
                self.updateUI(text)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    let destination = ContentListViewController()
                    self.navigationController?.pushViewController(destination, animated: true)
                }
            } onError: { error in
                self.presentAlert(message: error)
            }
        } onError: { error in
            self.presentAlert(message: error)
        }
        completion()
    }

    //MARK: - METHODS
    
    private func setUI() {
        self.view.createGradientLayer([UIColor.systemOrange.cgColor, UIColor.systemRed.cgColor], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        label.styleText(.large50, .lRegular, .white, .center)
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func updateUI(_ text: String) {
        label.text = text
    }


    
//    private func getFontName() {
//        for family: String in UIFont.familyNames
//        {
//            print(family)
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
//    }
}
