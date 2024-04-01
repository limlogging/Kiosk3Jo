//
//  ProductCell.swift
//  Kiosk
//
//  Created by 김시종 on 4/1/24.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    // 이미지 뷰
    let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 제품 이름 레이블
    let productLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 제품 가격 레이블
    let productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(productImage)
        addSubview(productLabel)
        addSubview(productPrice)
        
        NSLayoutConstraint.activate([
            // 이미지 뷰
            productImage.topAnchor.constraint(equalTo: topAnchor),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 150), // 이미지 높이 조정
            
            // 제품 이름 레이블
            productLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 8),
            productLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            // 제품 가격 레이블
            productPrice.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 4),
            productPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: AppleProduct) {
        productImage.image = product.image
        productLabel.text = product.name
        productPrice.text = "\(product.price)"
    }
}



