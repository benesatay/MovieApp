//
//  BaseCollectionView.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 20.07.2021.
//
import UIKit

protocol CollectionViewDelegate: AnyObject {
    func goToController(_ data: Any?)
}

class BaseCollectionView: UIView {
    
    weak var collectionDelegate: CollectionViewDelegate?
    
    
    private  var _dataCollection: [Any] = []
    
    lazy private var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var _isHorizontal = false
    private var _collectionCell: AppConstants.CollectionCell = .none
    init(isHorizontal: Bool = false, collectionCell: AppConstants.CollectionCell = .none) {
        _isHorizontal = isHorizontal
        _collectionCell = collectionCell
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    private func setUI()  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = _isHorizontal ? .horizontal : .vertical
        collectionView.collectionViewLayout = layout
        
        if _collectionCell == .movieCell {
            collectionView.register(MovieCell.self, forCellWithReuseIdentifier: _collectionCell.rawValue)
        } else if _collectionCell == .relatedMovieCell {
            collectionView.register(RelatedMovieCell.self, forCellWithReuseIdentifier: _collectionCell.rawValue)
        }
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    public func updateData(_ data: [Any]) {
        _dataCollection = data
        collectionView.reloadData()
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }

}

extension BaseCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if _collectionCell == .movieCell || _collectionCell == .relatedMovieCell {
            if let data = _dataCollection[indexPath.row] as? SearchResponse,
               let id = data.imdbID {
                collectionDelegate?.goToController(id)
            }
        } else { }
    }
}

extension BaseCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _dataCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if _collectionCell == .movieCell {
            let data = _dataCollection[indexPath.row] as? SearchResponse
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _collectionCell.rawValue, for: indexPath) as! MovieCell
            cell.data = data
            return cell
        }
        else if _collectionCell == .relatedMovieCell {
            let data = _dataCollection[indexPath.row] as? SearchResponse
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _collectionCell.rawValue, for: indexPath) as! RelatedMovieCell
            cell.data = data
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
}


extension BaseCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if _collectionCell == .movieCell {
            let cellWidth = (self.frame.width-50)/2
            return CGSize(width: cellWidth, height: cellWidth*2)
        } else if _collectionCell == .relatedMovieCell {
            return self.collectionView.bounds.size
//            let cellWith = (self.frame.width-50)/4
//            return CGSize(width: cellWith, height: cellWith*3/2)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GAP
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return GAP
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: GAP, left: LARGE_GAP, bottom: LARGE_GAP, right: LARGE_GAP)
    }
}


