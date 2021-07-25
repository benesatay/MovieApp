//
//  BaseViewController.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 17.07.2021.
//

import UIKit
import SnapKit
import Kingfisher

class BaseViewController: UIViewController {
    
    lazy private var processingView: ProcessingView? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        setRemoteConfig()
    }
    
    deinit {
        cLog("no retain cycle")
        
    }
    
    private func setRemoteConfig() {
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }

    //MARK: - PUBLICS

    public func startLoading() {
        processingView = ProcessingView()
        self.view.addSubview(processingView!)
        processingView!.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(5*LARGE_GAP)
        }
        self.processingView!.startLoading()
    }
    
    public func stopLoading() {
        self.processingView!.stopLoading()
        self.processingView!.removeFromSuperview()
        self.processingView = nil
    }
    
    public func presentAlert(title: String, message: String) {
        let alert = AppAlert(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
    }
    
    public func pushViewController(_ controller: BaseViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    public func presentViewController(_ controller: BaseViewController) {
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
}
