//
//  BaseView.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 21.07.2021.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViews() {
        
    }
}
