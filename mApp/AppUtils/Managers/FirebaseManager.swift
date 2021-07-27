//
//  FirebaseManager.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 26.07.2021.
//

import Foundation
import FirebaseAnalytics
import UIKit

class Logger {
    
    static let shared = Logger()
    
    private init() { }

    public func logEvent(_ key: String, _ value: Any) {
        FirebaseAnalytics.Analytics.logEvent("detail_screen_viewed", parameters: [
            AnalyticsParameterScreenName: "content_detail_view",
            key : value
        ])
    }
}

class ConfigManager {
    
    static let shared = ConfigManager()
   
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private init() { }

    public func setRemoteConfigDefault() {
        let defaultVal = ["txt" : "Loodos" as NSObject]
        appDelegate.remoteConfig.setDefaults(defaultVal)
    }
    
    public func getRemoteConfigValue(onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        appDelegate.remoteConfig.fetch { status, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    onError(error!.localizedDescription)
                }
                return
            }
            if status == .success {
                self.appDelegate.remoteConfig.activate { changed, error in
                    guard error == nil else {
                        DispatchQueue.main.async {
                            onError(error!.localizedDescription)
                        }
                        return
                    }
                    if let text = self.appDelegate.remoteConfig.configValue(forKey: "txt").stringValue {
                        DispatchQueue.main.async {
                            onSuccess(text)
                        }
                    }
                }
            }
        }
    }
    
}
