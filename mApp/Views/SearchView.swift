//
//  CustomSearchBar.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 19.07.2021.
//

import UIKit
protocol SearchViewDelegate: AnyObject {
    func searchMovie(_ name: String)
    func reloadData()
}


class SearchView: BaseView {
    
    weak var searchDelegate: SearchViewDelegate?
    
    lazy private var textField = CustomTextField(UIEdgeInsets(top: GAP, left: GAP, bottom: GAP, right: GAP))
    lazy private var cancelButton = UIButton()
  
    override func setupViews() {
        self.setUI()
    }
    
    //MARK: - ACTIONS
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.cancelSearching()
    }
    
    //MARK: - METHODS

    private func setUI() {
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(0)
            make.height.equalTo(50)
        }
        
        textField.font = UIFont(name: Font.name.iRegular.description, size: Font.size.medium16.value)
        let placeholder = AppLocalization.text(.GLOBAL_SEARCH_BAR_PLACEHOLDER)
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: placeholder)
        let color = UIColor.lightText.withAlphaComponent(0.5)
        attributedText.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: placeholder.count))
        textField.attributedPlaceholder = attributedText
        textField.tintColor = color.withAlphaComponent(0.5)
        textField.textColor = color.withAlphaComponent(1)
        textField.delegate = self
        textField.setKeyboardAppearance(.alert)
        textField.setReturnKeyType(.search)

        self.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.left.equalTo(textField.snp.right).offset(LARGE_GAP)
        }
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        cancelButton.setTitle(AppLocalization.text(.GLOBAL_CANCEL_BUTTON_TITLE), for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
    }
    
    private func hideCancelButton() {
        self.textField.snp.updateConstraints { make in
            make.right.equalToSuperview().inset(0)
        }
        self.cancelButton.snp.remakeConstraints { make in
            make.centerY.equalTo(textField)
            make.left.equalTo(textField.snp.right).offset(LARGE_GAP)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func showCancelButton() {
        self.textField.snp.updateConstraints { make in
            make.right.equalToSuperview().inset(self.bounds.size.width/4)
        }
        self.cancelButton.snp.remakeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(textField)
            make.left.equalTo(textField.snp.right).offset(LARGE_GAP)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func cancelSearching() {
        self.textField.text?.removeAll()
        self.endEditing(true)
        self.hideCancelButton()
        searchDelegate?.reloadData()
    }
    
    private func getFormattedText(_ movieName: String) -> String {
        var text = movieName
        if text.last == " " {
            text.removeLast()
        }
        text = text.replacingOccurrences(of: " ", with: "+")
        return text
    }
    
    public func getText() -> String {
        let text = self.getFormattedText(textField.text ?? "")
        return text
    }
}

//MARK: - EXTENSIONS

extension SearchView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showCancelButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.hideCancelButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            let movieName = self.getFormattedText(text)
            searchDelegate?.searchMovie(movieName)
            self.endEditing(true)
            return true
        }
        return false
    }
    
    

}
