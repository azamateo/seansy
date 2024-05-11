import UIKit
import WebKit
import SnapKit

class MoviePreviewController: UIViewController {
    
    var sessionService: SessionService!
    var sessions: [SessionsModel] = []
    let currentDate = Date()
    
    private lazy var scrollView: UIScrollView = {
         let scrollView = UIScrollView()
         return scrollView
     }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.text = "Harry Potter"
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 2
        label.text = "This is the best movie ever to watch as a kid!"
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .orange
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var premiereDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(genresLabel)
        scrollView.addSubview(ratingImageView)
        scrollView.addSubview(ratingLabel)
        scrollView.addSubview(premiereDateLabel)
        configureConstraints()
    }
    
    func configureConstraints() {
        webView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.width.equalTo(scrollView)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(scrollView)
        }
        
        ratingImageView.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingImageView)
            make.leading.equalTo(ratingImageView.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        
        premiereDateLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingImageView.snp.bottom).offset(10)
            make.leading.equalTo(ratingImageView.snp.leading)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.width.equalTo(scrollView)
        }
    }
    
    public func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.movie.name_rus
        overviewLabel.text = model.movie.name_origin
        
        if let genres = model.movie.genres {
            let genresString = genres.compactMap { $0.title }.joined(separator: " • ")
            genresLabel.text = genresString
        } else {
            genresLabel.text = nil
        }

        if let rating = model.movie.rating {
            let ratingImageName: String
            if rating >= 7.0 {
                ratingImageName = "star.fill"
            } else if rating >= 5.0 {
                ratingImageName = "star.leadinghalf.fill"
            } else {
                ratingImageName = "star"
            }
            ratingImageView.image = UIImage(systemName: ratingImageName)
            ratingLabel.text = String(format: "%.1f/10", rating)
        } else {
            ratingImageView.image = nil
            ratingLabel.text = "Нет данных"
        }
        
        if let premiereDateString = model.movie.premiere_kaz {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let premiereDate = dateFormatter.date(from: premiereDateString) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let formattedPremiereDate = dateFormatter.string(from: premiereDate)
                premiereDateLabel.text = "Премьера: \(formattedPremiereDate)"
            } else {
                premiereDateLabel.text = nil
            }
        } else {
            premiereDateLabel.text = nil
        }
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedCurrentDate = dateFormatter.string(from: currentDate)
        fetchSessions(movie_id: model.movie.id, date: formattedCurrentDate, city_id: 1)
    }
    
    func fetchSessions(movie_id: Int, date: String, city_id: Int) {
        let apiConfig = KinoKZConfiguration()
        sessionService = SessionService(configuration: apiConfig)
        Task {
            do {
                let sessions_result = try await sessionService.list(movie_id: movie_id, date: date, city_id: city_id)
                self.sessions = sessions_result
                print("Sessions Count: \(self.sessions.count)")
                addSessionViews()
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    func addSessionViews() {
        var previousView: UIView?
        var totalHeight: CGFloat = 0
        
        for session in sessions {
            let sessionView = createSessionView(session: session)
            scrollView.addSubview(sessionView) // Add sessionView to scrollView
            
            sessionView.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(20)
                make.trailing.equalToSuperview().inset(-20)
                if let previous = previousView {
                    make.top.equalTo(previous.snp.bottom).offset(10)
                } else {
                    make.top.equalTo(premiereDateLabel.snp.bottom).offset(20)
                }
            }
            
            previousView = sessionView
            
            // Update totalHeight based on the height of the added sessionView
            totalHeight += sessionView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + 32 // Add some spacing between sessionViews
        }
        
        // Update content size of scrollView based on the total height
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: totalHeight)
    }

    
    private func createSessionView(session: SessionsModel) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        
        let cinemaLabel = UILabel()
        cinemaLabel.font = .systemFont(ofSize: 16, weight: .bold)
        cinemaLabel.text = session.cinema.name
        
        let hallLabel = UILabel()
        hallLabel.font = .systemFont(ofSize: 14, weight: .regular)
        hallLabel.text = "Зал: \(session.hall.name)"
        
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.text = "Время: \(session.session.session_date)"
        let sessionDateString = session.session.session_date_tz
        print("SessionDate:\(sessionDateString)")
        
        if (!sessionDateString.isEmpty){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let sessionDate = dateFormatter.date(from: sessionDateString) {
                dateFormatter.dateFormat = "dd.MM HH:mm"
                let formattedSessionDate = dateFormatter.string(from: sessionDate)
                dateLabel.text = "Время: \(formattedSessionDate)"
            } else {
                dateLabel.text = nil
            }
        } else {
            dateLabel.text = nil
        }
        containerView.addSubview(cinemaLabel)
        containerView.addSubview(hallLabel)
        containerView.addSubview(dateLabel)
        
        cinemaLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        hallLabel.snp.makeConstraints { make in
            make.top.equalTo(cinemaLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(hallLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        return containerView
    }
}
