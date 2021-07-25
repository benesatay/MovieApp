//
//  CustomTextField.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 21.07.2021.
//
import UIKit

class CustomTextField: UITextField {

    private var _padding: UIEdgeInsets = .zero
    
    init(_ padding: UIEdgeInsets) {
        _padding = padding
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }

    private func setUI() {
        self.layer.cornerRadius = 15
        self.addShadow(.white, 0.3)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)

    }
    
    public func setReturnKeyType(_ returnKey: UIReturnKeyType) {
        self.returnKeyType = returnKey
    }
    
    public func setKeyboardAppearance(_ appearance: UIKeyboardAppearance) {
        self.keyboardAppearance = appearance
    }
    
    
}
