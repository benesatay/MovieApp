//
//  SplashViewController.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 17.07.2021.
//

import UIKit
import Network

class SplashViewController: BaseViewController {
    
    lazy private var label = CustomLabel()
    
    lazy private var monitor = NWPathMonitor()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkInternetConnection {
            self.monitor.cancel()
        }
        getFontName()
    }

    //MARK: - FIREBASE REMOTE CONFIG
    
    private func setRemoteConfigDefault() {
        let defaultVal = ["txt" : "Loodos" as NSObject]
        remoteConfig.setDefaults(defaultVal)
    }
    
    private func getRemoteConfigValue() {
        remoteConfig.fetch { status, error in
            guard error == nil else {
                return
                    self.presentAlert(title: "Error!", message: error!.localizedDescription)
            }
            if status == .success {
                remoteConfig.activate { changed, error in
                    guard error == nil else {
                        return
                            self.presentAlert(title: "Error!", message: error!.localizedDescription)
                    }
                    let text = remoteConfig.configValue(forKey: "txt").stringValue ?? ""
                    DispatchQueue.main.async {
                        self.updateUI(text)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            let destination = HomeViewController()
                            self.pushViewController(destination)
                        }
                    }
                }
            }
        }
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
    

    
    private func checkInternetConnection(completion: () -> ()) {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                DispatchQueue.main.async {
                    self.setUI()
                    self.setRemoteConfigDefault()
                    self.getRemoteConfigValue()
                }
            } else {
                DispatchQueue.main.async {
                    self.presentAlert(title: "Error!", message: "No Internet Connection!")
                }
            }
        }
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
        completion()
    }
    
    
    
    
    
    
    private func getFontName() {
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
}
