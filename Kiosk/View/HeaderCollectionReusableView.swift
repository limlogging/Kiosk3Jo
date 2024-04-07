//
//  HeaderCollectionReusableView.swift
//  HomeTab
//
//  Created by 김시종 on 4/4/24.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    //static let identifier = "HeaderCollectionReusableView"
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "최신 제품. 이곳에서 쇼핑하는 이유"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    public func configure() {
        backgroundColor = .systemGray5
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
