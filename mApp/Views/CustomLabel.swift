//
//  CustomLabel.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import UIKit

class CustomLabel: UILabel {
    
    var edgeInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
       
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: edgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(
            top: -edgeInsets.top,
            left: -edgeInsets.left,
            bottom: -edgeInsets.bottom,
            right: -edgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.defaultLabel()
    }

    init() {
        super.init(frame: .zero)
        self.defaultLabel()
    }
    
    //MARK: - METHODS

    private func defaultLabel() {
        self.backgroundColor = .clear
        self.font = UIFont.init(name: Font.name.iRegular.description, size: Font.size.normal14.value)
        self.textColor = .darkText
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 0
        self.clipsToBounds = true
    }
    
    //MARK: - PUBLICS
    
    public func appendAndFormatText(_ subText: String, _ text: String, _ mainColor: UIColor = .lightText) {
        self.text?.append(text)
        self.textColor = mainColor
        let color: UIColor = .white
        let subStrFont = UIFont(name: Font.name.iMedium.description, size: Font.size.big18.value)
        self.styleSubstring(subText, color, subStrFont)
    }
    
    public func detailStyle(_ text: String) {
        self.styleText(.medium16, .iMedium, .lightText, .center)
        let lineFeed: AppConstants.ASCIIControl = .lineFeed
        self.text = text + lineFeed.character
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.layer.cornerRadius = 10
        self.edgeInsets = UIEdgeInsets(top: SMALL_GAP, left: SMALL_GAP, bottom: SMALL_GAP, right: SMALL_GAP)
    }
    
    public func styleText(_ fontSize: Font.size, _ font: Font.name, _ textColor: UIColor, _ textAlignment: NSTextAlignment) {
        self.font = UIFont.init(name: font.description, size: fontSize.value)
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
    
    public func styleSubstring(_ substring: String, _ color: UIColor? = nil, _ font: UIFont? = nil) -> Void {
        let range = (self.text! as NSString).range(of: substring) as NSRange
        
        var attributedText: NSMutableAttributedString?
        
        if self.attributedText == nil {
            attributedText = NSMutableAttributedString(string: self.text!)
        } else {
            attributedText = NSMutableAttributedString(attributedString: self.attributedText!)
        }
   
        if let subStrFont = font {
            attributedText?.addAttributes([NSAttributedString.Key.font: subStrFont], range: range)
        }
        if let clr = color {
            attributedText?.addAttributes([NSAttributedString.Key.foregroundColor: clr], range: range)
        }

        self.attributedText = attributedText
    }
}
