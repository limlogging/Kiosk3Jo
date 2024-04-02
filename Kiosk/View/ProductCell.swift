//
//  ProductCell.swift
//  Kiosk
//
//  Created by 김시종 on 4/1/24.
//

import UIKit

class ProductCell: UICollectionViewCell {
// MARK: - code cell 구현
    
    let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

// MARK: - autolayout 구현
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(productImage)
        addSubview(productLabel)
        addSubview(productPrice)
        
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: topAnchor),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 150),
            productImage.widthAnchor.constraint(equalToConstant: 150),
            
            productLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 8),
            productLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            productPrice.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 4),
            productPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productPrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - 데이터 할당
    func configure(with product: AppleProduct) {
        productImage.image = product.image
        productLabel.text = product.name
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: product.price)) {
            productPrice.text = formattedPrice
        } else {
            productPrice.text = "\(product.price)"
        }
    }
}
