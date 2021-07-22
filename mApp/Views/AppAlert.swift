//
//  AppAlert.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 17.07.2021.
//

import UIKit

class AppAlert: UIAlertController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setOKButton()
    }
    
    private func setOKButton() {
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        self.addAction(okButton)
    }
}
