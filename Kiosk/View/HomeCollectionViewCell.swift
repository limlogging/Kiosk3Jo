




import UIKit



class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    let homeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(homeImage)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            homeImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            homeImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            homeImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: 0),
            homeImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: 0),
            homeImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            homeImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 10)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
