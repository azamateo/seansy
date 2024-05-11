
import UIKit
import SnapKit

class HeroHeaderUIView: UIView {
    
    
    private let title: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.backgroundColor = .black
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()

    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(heroImageView.snp_topMargin).offset(400)
            make.left.equalTo(heroImageView.snp_leftMargin).offset(20)
            make.height.equalTo(40)
            
        }
    }
    

    
    public func configure(movie:Movie) {
        guard let url = URL(string: movie.small_poster! ) else {
            return
        }
        let movie = movie
    
        
        heroImageView.sd_setImage(with: url, completed: nil)
        title.text = movie.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
