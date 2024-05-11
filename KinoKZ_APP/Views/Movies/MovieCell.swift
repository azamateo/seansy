//
//  MovieCell.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 04.05.2024.
//

import Foundation
import UIKit
import SnapKit

class MovieCell: UICollectionViewCell{
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

