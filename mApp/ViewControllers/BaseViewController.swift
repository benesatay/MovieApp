//
//  BaseViewController.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 17.07.2021.
//

import UIKit
import SnapKit
import Kingfisher
import Firebase

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

    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    deinit {
//        cLog("")
//    }
    


    //MARK: - PUBLICS

    public func startLoading() {
        processingView = ProcessingView()
        self.view.addSubview(processingView!)
        processingView!.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(8*LARGE_GAP)
        }
        self.processingView!.startLoading()
    }
    
    public func stopLoading() {
        self.processingView!.stopLoading()
        self.processingView!.removeFromSuperview()
        self.processingView = nil
    }
    
    public func presentAlert(title: String = AppLocalization.text(.GLOBAL_ERROR_ALERT_TITLE), message: String) {
        let alert = AppAlert(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
    }
}
