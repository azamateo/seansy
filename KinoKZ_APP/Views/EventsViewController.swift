//
//  EventsViewController.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 05.05.2024.
//

import Foundation

import UIKit
enum Events_Sections: Int {
    case Events = 1
}

class EventsViewController: UIViewController  {

    
    var movieService: EventsService!
    var events: [Event] = []
    private var randomTrendingMovie: Event?
    private var headerView: HeroHeaderUIViewEvents?
    
    let sectionTitles: [String] = ["Концерты"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(EventsCollectionViewTableViewCell.self, forCellReuseIdentifier: EventsCollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        fetchEvents(cityId: 1, startDate: "2024-04-28", endDate: "2024-12-31", eventType: "Концерты")
        
        headerView = HeroHeaderUIViewEvents(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView

        
    }
    
        func fetchEvents(cityId: Int, startDate: String, endDate: String, eventType: String) {
            let apiConfig = KinoKZConfiguration()
            let eventService = EventsService(configuration: apiConfig)
            Task {
                do {
                    let events_result = try await eventService.list(cityId: cityId, startDate: startDate, endDate: endDate, eventType: eventType)
                    self.events = events_result.result
                    DispatchQueue.main.async {
                        self.homeFeedTable.reloadData() // Reload table view after fetching movies
                    }
                    configureHeroHeaderView()
                } catch {
                    print("Error fetching events: \(error)")
                }
            }
        }

    private func configureHeroHeaderView() {
        let random = events.randomElement()
        self.headerView?.configure(event: random!)
    
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "kinokz")
    
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "building.2.crop.circle.fill"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: nil)
        ]
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }


    
}


extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsCollectionViewTableViewCell.identifier, for: indexPath) as? EventsCollectionViewTableViewCell else {
                    return UITableViewCell()
                }

        cell.delegate = self

        cell.configure(with: events)
        
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



extension EventsViewController: EventsCollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: EventsCollectionViewTableViewCell, viewModel: EventsModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewController()
//            vc.configure(movie_: )
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
