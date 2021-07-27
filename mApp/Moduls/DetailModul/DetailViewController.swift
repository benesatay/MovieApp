//
//  DetailViewController.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 26.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func getFetchedDetail(viewModel: Detail.FetchRequest.ViewModel)
    func presentError(_ error: String)
}


class DetailViewController: BaseViewController {
    
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic)? //(NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
    lazy private var scrollView = UIScrollView()
    lazy private var contentView = UIView()
    
    lazy private var dismissButton = UIButton()
    
    lazy private var titleLabel = CustomLabel()
    lazy private var posterView = UIImageView()
    
    lazy private var yearLabel = CustomLabel()
    lazy private var ratingLabel = CustomLabel()
    lazy private var typeLabel = CustomLabel()
    lazy private var runtimeLabel = CustomLabel()
    
    lazy private var directorLabel = CustomLabel()
    lazy private var writerLabel = CustomLabel()
    lazy private var genreLabel = CustomLabel()
    
    lazy private var awardsLabel = CustomLabel()
    lazy private var productionLabel = CustomLabel()
    
    lazy private var plotLabel = CustomLabel()
    
    private let _movieID: String
    init(_ movieID: String) {
        self._movieID = movieID
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
//        router.dataStore = interactor
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.requestSelectedContentData()
    }

    //MARK: - ACTIONS
    @IBAction func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - REQUEST CONTENT DATA
    private func requestSelectedContentData() {
        self.startLoading()
        let request = ContentDetailRequest()
        request.id = _movieID
        if let plotType = PlotType.full.description {
            request.plot = plotType
        }
        interactor?.getDetail(request: request)
    }
    
    //MARK: - METHODS
    private func setUI() {
        let colors = [UIColor.systemRed, UIColor.systemPurple, UIColor.systemTeal]
        let randomColor = colors.randomElement()
        self.view.createGradientLayer(
            [UIColor.black.cgColor , randomColor!.cgColor],
            startPoint: CGPoint(x: 0.75, y: 1), endPoint: CGPoint(x: 1, y: 0))
        
        self.view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(GAP)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
        
        titleLabel.styleText(.large30, .iSemibold, .white, .left)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2*LARGE_GAP)
            make.left.equalToSuperview().inset(LARGE_GAP)
            make.right.equalToSuperview().inset(2*LARGE_GAP + 50)
        }
        
        contentView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().inset(LARGE_GAP)
            make.size.equalTo(50)
            make.left.equalTo(titleLabel.snp.right).offset(LARGE_GAP)
        }
        dismissButton.imageView?.contentMode = .scaleAspectFill
        dismissButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        dismissButton.tintColor = .white
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        
        let posterBG = UIView()
        posterBG.layer.cornerRadius = 40
        posterBG.addShadow(.black, 0.3)
        contentView.addSubview(posterBG)
        posterBG.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(LARGE_GAP)
            make.centerX.equalToSuperview()
        }
        
        posterView.contentMode = .scaleAspectFit
        posterView.layer.cornerRadius = posterBG.layer.cornerRadius
        posterView.clipsToBounds = true
        posterBG.addSubview(posterView)
        posterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        typeLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_TYPE_TITLE))
        yearLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_YEAR_TITLE))
        ratingLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_RATING_TITLE))
        runtimeLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_RUNTIME_TITLE))
        let topStack = self.setStack([typeLabel, yearLabel, ratingLabel, runtimeLabel])
        self.contentView.addSubview(topStack)
        topStack.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom).offset(LARGE_GAP)
            make.left.right.equalToSuperview().inset(LARGE_GAP)
        }
                
        awardsLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_AWARDS_TITLE))
        self.contentView.addSubview(awardsLabel)
        self.awardsLabel.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom).offset(GAP)
            make.left.right.equalToSuperview().inset(LARGE_GAP)
        }
        
        directorLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_DIRECTOR_TITLE))
        self.contentView.addSubview(directorLabel)
        self.directorLabel.snp.makeConstraints { make in
            make.top.equalTo(awardsLabel.snp.bottom).offset(GAP)
            make.left.equalToSuperview().inset(LARGE_GAP)
            make.width.lessThanOrEqualToSuperview().dividedBy(2)
        }
        
        writerLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_WRITER_TITLE))
        self.contentView.addSubview(writerLabel)
        self.writerLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel)
            make.left.equalTo(directorLabel.snp.right).offset(GAP)
            make.width.equalTo(directorLabel)
            make.right.equalToSuperview().inset(LARGE_GAP)
        }
        
        genreLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_GENRE_TITLE))
        self.contentView.addSubview(genreLabel)
        self.genreLabel.snp.makeConstraints { make in
            make.top.equalTo(writerLabel.snp.bottom).offset(GAP)
            make.left.equalTo(writerLabel)
            make.width.equalTo(writerLabel)
        }
        
        productionLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_PRODUCTION_TITLE))
        self.contentView.addSubview(productionLabel)
        self.productionLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).offset(GAP)
            make.left.equalTo(directorLabel)
            make.width.equalTo(directorLabel)
            make.bottom.equalTo(genreLabel)
        }
        
        plotLabel.setDetailStyle(with: AppLocalization.text(.DETAIL_PLOT_TITLE))
        self.contentView.addSubview(plotLabel)
        self.plotLabel.snp.makeConstraints { make in
            make.top.equalTo(productionLabel.snp.bottom).offset(2*LARGE_GAP)
            make.left.right.equalToSuperview().inset(LARGE_GAP)
            make.bottom.lessThanOrEqualToSuperview().inset(2*LARGE_GAP)
        }
    }
  
    private func setStack(_ arrangedSubviews: [CustomLabel], _ axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stack = UIStackView()
        for subview in arrangedSubviews {
            stack.addArrangedSubview(subview)
        }
        stack.distribution = .fillEqually
        stack.spacing = SMALL_GAP
        stack.axis = axis
        return stack
    }
    
    private func updateUI(_ movie: Detail.FetchRequest.ViewModel.ContentData) {
        if let posterURL = URL(string: movie.image) {
            posterView.kf.setImage(with: posterURL)
        }
        titleLabel.text = movie.title
        self.setRatingTextAndColor(movie.rating)
        directorLabel.appendAndFormatText(AppLocalization.text(.DETAIL_DIRECTOR_TITLE), movie.director)
        writerLabel.appendAndFormatText(AppLocalization.text(.DETAIL_WRITER_TITLE), movie.writer)
        yearLabel.appendAndFormatText(AppLocalization.text(.DETAIL_YEAR_TITLE), movie.year)
        genreLabel.appendAndFormatText(AppLocalization.text(.DETAIL_GENRE_TITLE), movie.genre)
        awardsLabel.appendAndFormatText(AppLocalization.text(.DETAIL_AWARDS_TITLE), movie.awards)
        productionLabel.appendAndFormatText(AppLocalization.text(.DETAIL_PRODUCTION_TITLE), movie.production)
        typeLabel.appendAndFormatText(AppLocalization.text(.DETAIL_TYPE_TITLE), movie.type)
        runtimeLabel.appendAndFormatText(AppLocalization.text(.DETAIL_RUNTIME_TITLE), movie.runtime)
        plotLabel.appendAndFormatText(AppLocalization.text(.DETAIL_PLOT_TITLE), movie.plot)
    }
    
    private func setRatingTextAndColor(_ imdbRating: String) {
        let rating = Double(imdbRating) ?? 0
        let ratingColor = RatingColor.setColor(rating)
        ratingLabel.appendAndFormatText(AppLocalization.text(.DETAIL_RATING_TITLE), imdbRating, ratingColor.color)
    }
}

//MARK: - GET DETAIL RESPONSE

extension DetailViewController: DetailDisplayLogic {
    func getFetchedDetail(viewModel: Detail.FetchRequest.ViewModel) {
        self.stopLoading()
        let contentDetail = viewModel.contentData
        self.updateUI(contentDetail)
    }
    
    func presentError(_ error: String) {
        self.presentAlert(message: error)
        self.stopLoading()
    }    
}

//MARK: - RATING COLOR ENUM

enum RatingColor {
    case low
    case medium
    case high

    var color: UIColor {
        switch self {
        case .low:
            return .systemOrange
        case .medium:
            return UIColor(red: 253/256, green: 252/256, blue: 71/256, alpha: 1)
        case .high:
            return UIColor(red: 36/256, green: 254/256, blue: 65/256, alpha: 1)
        }
    }

    static func setColor(_ rating: Double) -> RatingColor {
        var color: RatingColor = .low
        if rating < 5 {
            color = .low
        } else if rating >= 5 && rating < 8 {
            color = .medium
        } else {
            color = .high
        }
        return color
    }
}

