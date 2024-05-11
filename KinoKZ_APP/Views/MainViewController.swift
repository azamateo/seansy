//
//  ViewController.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import UIKit
enum Sections: Int {
    case Movies = 0
}



class MainViewController: UIViewController  {

    
    var movieService: MoviesService!
    var movies: [Movie] = []
    private var randomTrendingMovie: Movie?
    private var headerView: HeroHeaderUIView?
    
    let sectionTitles: [String] = ["Фильмы"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MoviesCollectionViewTableViewCell.self, forCellReuseIdentifier: MoviesCollectionViewTableViewCell.identifier)
        //table.register(EventsCollectionViewTableCell.self, forCellReuseIdentifier: EventsCollectionViewTableCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        fetchMovies(cityId: 1, startDate: "2024-05-01", endDate: "2024-06-01")
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView

        
    }
    

    func fetchMovies(cityId: Int, startDate: String, endDate: String) {
        let apiConfig = KinoKZConfiguration()
        movieService = MoviesService(configuration: apiConfig)
        Task {
            do {
                let movies_result = try await movieService.list(cityId: cityId, startDate: startDate, endDate: endDate)
                self.movies = movies_result.result
                print("1 films Count: \(self.movies.count)")
                DispatchQueue.main.async {
                    self.homeFeedTable.reloadData() // Reload table view after fetching movies
                }
                configureHeroHeaderView() // Update hero header view after fetching movies
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }

    private func configureHeroHeaderView() {
        let random = movies.randomElement()
        self.headerView?.configure(movie: random!)
    
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "kinokz")
    
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
//        navigationItem.rightBarButtonItems = [
//            UIBarButtonItem(image: UIImage(systemName: "building.2.crop.circle.fill"), style: .done, target: self, action: nil),
//            UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: nil)
//        ]
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }


    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: MoviesCollectionViewTableViewCell.identifier, for: indexPath) as? MoviesCollectionViewTableViewCell else {
                    return UITableViewCell()
                }
        
        cell.delegate = self

        switch indexPath.section {
        case Sections.Movies.rawValue:
            cell.configure(with: movies)
        default:
            return UITableViewCell()

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}



extension MainViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: MoviesCollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


    



//class MainViewController: UICollectionViewController {
//    
//    let cellId = "cellId"
//    let cellId1 = "cellId1"
//    let padding: CGFloat = 1
//    
//    var movieService: MoviesService!
//    var movies: [Movie] = []
//    var loadingIndicator: UIActivityIndicatorView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupCollectionView()
//        setupLoadingIndicator()
//        fetchMovies(cityId: 18, startDate: "2024-03-01", endDate: "2024-12-31")
//    }
//    
//    func setupLoadingIndicator() {
//        loadingIndicator = UIActivityIndicatorView(style: .medium)
//        loadingIndicator.center = view.center
//        loadingIndicator.hidesWhenStopped = true
//        view.addSubview(loadingIndicator)
//    }
//    
//    func showLoadingIndicator() {
//        loadingIndicator.startAnimating()
//    }
//    
//    func hideLoadingIndicator() {
//        loadingIndicator.stopAnimating()
//    }
//    
//    func setupCollectionView(){
//        navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.barStyle = .black
//        collectionView.backgroundColor = .black
//        collectionView.register(UserDetailCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId1)
//    }
//    
//    fileprivate func fetchMovies(cityId: Int, startDate: String, endDate: String) {
//        showLoadingIndicator()
//        let apiConfig = KinoKZConfiguration()
//        movieService = MoviesService(configuration: apiConfig)
//        Task {
//            do {
//                let fetch = try await movieService.list(cityId: cityId, startDate: startDate, endDate: endDate)
//                let moviesList = fetch.result
//                self.movies = moviesList
//                print("1 Movies count:\(self.movies.count)")
//                DispatchQueue.main.async {
//                    self.hideLoadingIndicator()
//                    self.collectionView.reloadData()
//                }
//            } catch {
//                print("Error fetching movies: \(error)")
//            }
//        }
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // Add +1 to include the user detail cell
//        return movies.count + 1
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.item == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserDetailCell
//            cell.userName.text = "test"
//            cell.usernameHeader.text = "username"
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! MovieCell
//            // Adjust index to account for the user detail cell
//            let movie = movies[indexPath.item - 1]
//            cell.postImageView.kf.setImage(with: URL(string:movie.small_poster!))
//            cell.backgroundColor = .systemBlue
//            // Set up movie cell with data
//            return cell
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = UserDetailCell(frame: .init(x:0, y:0, width: view.frame.width, height: 3000))
//        cell.layoutIfNeeded()
//        let estimatedSize = cell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 3000))
//
//        return CGSize(width: collectionView.frame.width, height: estimatedSize.height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return padding
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return padding
//    }
//}






    
    //fetchEvents(cityId: 1, startDate: "2024-04-28", endDate: "2024-12-31", eventType: "Концерты")
//    var eventService: EventsService!
//    func fetchCinemas(cityId: Int, startDate: String, endDate: String) {
//        Task {
//            do {
//                let cinemas = try await MoviesService.
//                // Handle the cinemas array returned by the service
//                let cinema = cinemas.result[0].city_name
//                print(cinema)
//            } catch {
//                // Handle any errors
//                print("Error fetching cinemas: \(error)")
//            }
//        }
//    }
    
//    func fetchMovies(cityId: Int, startDate: String, endDate: String) {
//        let apiConfig = KinoKZConfiguration()
//        movieService = MoviesService(configuration: apiConfig)
//        Task {
//            do {
//                let movies = try await movieService.list(cityId: cityId, startDate: startDate, endDate: endDate)
//                let movie = movies.result[0].genres?[0].title
//                print(movie)
//            } catch {
//                print("Error fetching movies: \(error)")
//            }
//        }
//    }
    

//    func fetchEvents(cityId: Int, startDate: String, endDate: String, eventType: String) {
//        let apiConfig = KinoKZConfiguration()
//        let eventService = EventsService(configuration: apiConfig)
//        Task {
//            do {
//                let events = try await eventService.list(cityId: cityId, startDate: startDate, endDate: endDate, eventType: eventType)
//                
//                // Convert events model to data
//                let encoder = JSONEncoder()
//                encoder.outputFormatting = .prettyPrinted
//                let eventData = try encoder.encode(events)
//                
//                // Convert data to string
//                if let rawText = String(data: eventData, encoding: .utf8) {
//                    print("Raw Response Text:")
//                    print(rawText)
//                } else {
//                    print("Failed to extract raw response text.")
//                }
//                
//                // Process the events as needed
//                // let event = events.result[0].name
//                print(events)
//            } catch {
//                print("Error fetching events: \(error)")
//            }
//        }
//    }



