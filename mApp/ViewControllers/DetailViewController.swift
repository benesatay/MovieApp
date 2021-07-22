//
//  DetailViewController.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 19.07.2021.
//

import UIKit
import FirebaseAnalytics

class DetailViewController: BaseViewController {
    
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
    
    private var _movieID: String = ""
    init(_ movieID: String) {
        _movieID = movieID
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.getSelectedMovie()
    }
    
    //MARK: - ACTIONS
    
    @IBAction func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: - FIREBASE ANALYTICS
    
    func logEvent(_ key: String, _ value: Any) {
        FirebaseAnalytics.Analytics.logEvent("detail_screen_viewed", parameters: [
            AnalyticsParameterScreenName: "movie_detail_view",
            key : value
        ])
    }
    
    //MARK: - SERVICES
    
    private func getSelectedMovie() {
        let req = MovieRequest()
        req.id = _movieID
        ApiManager.getSelectedMovie(req) { response in
            let movie = response
            self.updateUI(movie)
        } onError: { error in
            self.presentAlert(title: "Error!", message: error)
        }
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
        }
        
        contentView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.right.equalToSuperview().inset(LARGE_GAP)
            make.left.equalTo(titleLabel.snp.right).offset(LARGE_GAP)
        }
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

        let topStack = self.setStack([typeLabel, yearLabel, ratingLabel, runtimeLabel])
        self.contentView.addSubview(topStack)
        topStack.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom).offset(LARGE_GAP)
            make.left.right.equalToSuperview().inset(LARGE_GAP)
        }
        
        let LABEL_GAP = GAP
        self.contentView.addSubview(awardsLabel)
        self.awardsLabel.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom).offset(LABEL_GAP)
            make.left.right.equalToSuperview().inset(LARGE_GAP)
        }
        
        self.contentView.addSubview(directorLabel)
        self.directorLabel.snp.makeConstraints { make in
            make.top.equalTo(awardsLabel.snp.bottom).offset(LABEL_GAP)
            make.left.equalToSuperview().inset(LARGE_GAP)
            make.width.lessThanOrEqualToSuperview().dividedBy(2)
        }
        
        self.contentView.addSubview(writerLabel)
        self.writerLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel)
            make.left.equalTo(directorLabel.snp.right).offset(GAP)
            make.width.equalTo(directorLabel)
            make.right.equalToSuperview().inset(LARGE_GAP)
        }
        
        self.contentView.addSubview(genreLabel)
        self.genreLabel.snp.makeConstraints { make in
            make.top.equalTo(writerLabel.snp.bottom).offset(LABEL_GAP)
            make.left.equalTo(writerLabel)
            make.width.equalTo(writerLabel)
        }
        
        self.contentView.addSubview(productionLabel)
        self.productionLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).offset(LABEL_GAP)
            make.left.equalTo(directorLabel)
            make.width.equalTo(directorLabel)
        }

        self.contentView.addSubview(plotLabel)
        self.plotLabel.snp.makeConstraints { make in
            make.top.equalTo(productionLabel.snp.bottom).offset(2*LARGE_GAP)
            make.left.right.equalToSuperview().inset(LARGE_GAP)
            make.bottom.lessThanOrEqualToSuperview().inset(2*LARGE_GAP)

        }
        
        typeLabel.detailStyle(AppLocalization.text(.DETAIL_TYPE_TITLE))
        yearLabel.detailStyle(AppLocalization.text(.DETAIL_YEAR_TITLE))
        ratingLabel.detailStyle(AppLocalization.text(.DETAIL_RATING_TITLE))
        runtimeLabel.detailStyle(AppLocalization.text(.DETAIL_RUNTIME_TITLE))
        directorLabel.detailStyle(AppLocalization.text(.DETAIL_DIRECTOR_TITLE))
        writerLabel.detailStyle(AppLocalization.text(.DETAIL_WRITER_TITLE))
        productionLabel.detailStyle(AppLocalization.text(.DETAIL_PRODUCTION_TITLE))
        genreLabel.detailStyle(AppLocalization.text(.DETAIL_GENRE_TITLE))
        awardsLabel.detailStyle(AppLocalization.text(.DETAIL_AWARDS_TITLE))
        plotLabel.detailStyle(AppLocalization.text(.DETAIL_PLOT_TITLE))
   
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
    
    private func updateUI(_ movie: MovieResponse) {
        if let urlStr = movie.poster, let posterURL = URL(string: urlStr) {
            posterView.kf.setImage(with: posterURL)
        }
     
        if let title = movie.title {
            titleLabel.text = title
            self.logEvent("movie_name", title)
        }
        
        if let imdbRating = movie.imdbRating {
            self.setRatingColor(imdbRating)
        }
        
        if let director = movie.director {
            directorLabel.appendAndFormatText(AppLocalization.text(.DETAIL_DIRECTOR_TITLE), director)
        }
        
        if let writer = movie.writer {
            writerLabel.appendAndFormatText(AppLocalization.text(.DETAIL_WRITER_TITLE), writer)
        }
        
        if let year = movie.year {
            yearLabel.appendAndFormatText(AppLocalization.text(.DETAIL_YEAR_TITLE), year)
        }
        
        if let genre = movie.genre {
            genreLabel.appendAndFormatText(AppLocalization.text(.DETAIL_GENRE_TITLE), genre)
        }
        
        if let awards = movie.awards {
            awardsLabel.appendAndFormatText(AppLocalization.text(.DETAIL_AWARDS_TITLE), awards)
        }
        
        if let production = movie.production {
            productionLabel.appendAndFormatText(AppLocalization.text(.DETAIL_PRODUCTION_TITLE), production)
        }
        
        if let type = movie.type {
            typeLabel.appendAndFormatText(AppLocalization.text(.DETAIL_TYPE_TITLE), type)
        }
        
        if let runtime = movie.runtime {
            runtimeLabel.appendAndFormatText(AppLocalization.text(.DETAIL_RUNTIME_TITLE), runtime)
        }
        
        if let plot = movie.plot {
            plotLabel.appendAndFormatText(AppLocalization.text(.DETAIL_PLOT_TITLE), plot)
        }
    }
    
    private func setRatingColor(_ imdbRating: String) {
        let rating = Double(imdbRating) ?? 0
        let ratingColor = RatingColor.setColor(rating)
        ratingLabel.appendAndFormatText(AppLocalization.text(.DETAIL_RATING_TITLE), imdbRating, ratingColor.color)

    }
}

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

