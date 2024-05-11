

import UIKit
import SwiftUI

protocol EventsCollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: EventsCollectionViewTableViewCell, viewModel: EventsModel)
}
class EventsCollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    
    private var events: [Event] = [Event]()
    weak var delegate: EventsCollectionViewTableViewCellDelegate?
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EventTitleCollectionViewCell.self, forCellWithReuseIdentifier: EventTitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    
    public func configure(with events: [Event]) {
        self.events = events
        print("events count\(events.count)")
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        
    
//        DataPersistenceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
//            switch result {
//            case .success():
//                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        

    }
}


extension EventsCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.identifier, for: indexPath) as? EventTitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = events[indexPath.row].small_poster else {
            return UICollectionViewCell()
        }
        cell.configure(event: events[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = events[indexPath.row]
        guard let titleName = title.name ?? title.name_origin else {
            return
        }
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.downloadTitleAt(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        
        return config
    }
    
    

    
    
}
