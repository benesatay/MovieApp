//
//  HomeViewController.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 17.07.2021.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private var _movies: [SearchResponse] = []

    lazy private var alertLabel = CustomLabel()
    lazy private var searchBar = SearchView()
    lazy private var collectionView = BaseCollectionView(collectionCell: .movieCell)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cColor = UIColor(hexaRGB: "#926AA6")!.cgColor
        let colors: [CGColor] = [cColor, UIColor.white.cgColor]
        self.view.createGradientLayer(colors, startPoint: CGPoint(x: 0.5, y: 1), endPoint: CGPoint(x: 0.5, y: 0))
        setUI()
    }
    
    //MARK: - SERVICE
    
    private func getMovies(_ name: String) {
        let req = MovieRequest()
        req.series = name
        ApiManager.getMovies(req) { response in
            self.hideAlertLabel()
            if let searchResult = response.search {
                self._movies = searchResult
                self.collectionView.updateData(self._movies)
            } else {
                self.showAlertLabel()
                self._movies = []
                self.collectionView.updateData([])
            }
        } onError: { error in
            self.presentAlert(title: "Error!", message: error)
        }
    }
    
    //MARK: - METHODS
    
    private func setUI() {
        searchBar.searchDelegate = self
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2.5*LARGE_GAP)
            make.left.right.equalToSuperview().inset(LARGE_GAP)
        }
        
        collectionView.collectionDelegate = self
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(GAP)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.createAlertLabel()
    }
 
    private func createAlertLabel() {
        alertLabel.styleText(.big20, .iSemibold, .darkText, .center)
        alertLabel.text = AppLocalization.text(.HOME_EMPTY_SEARCH_BAR_ALERT_TEXT)
        self.view.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func showAlertLabel() {
        alertLabel.isHidden = false
    }
    
    private func hideAlertLabel() {
        alertLabel.isHidden = true
    }
}

extension HomeViewController: CollectionViewDelegate {
    func goToController(_ data: Any?) {
        guard let movieID = data as? String  else { return }
        let destination = DetailViewController(movieID)
        self.presentViewController(destination)
    }
}

extension HomeViewController: SearchViewDelegate {
    func searchMovie(_ name: String) {
        self.getMovies(name)
        if name.isEmpty || name == "" {
            alertLabel.text = AppLocalization.text(.HOME_EMPTY_SEARCH_BAR_ALERT_TEXT)
        } else {
            alertLabel.text = AppLocalization.text(.HOME_NO_RESULT_ALERT_TEXT)
        }
    }
    
    func reloadData() {
        self.collectionView.updateData([])
        self.showAlertLabel()
        alertLabel.text = AppLocalization.text(.HOME_EMPTY_SEARCH_BAR_ALERT_TEXT)
    }
}
