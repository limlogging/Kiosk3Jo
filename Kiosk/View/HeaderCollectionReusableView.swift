//
//  HeaderCollectionReusableView.swift
//  HomeTab
//
//  Created by 김시종 on 4/4/24.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HeaderCollectionReusableView"
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "최신 제품. 따끈따끈한 신제품 이야기"
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
            label.topAnchor.constraint(equalTo: topAnchor, constant: 50), // 헤더의 상단으로부터 10 포인트 아래에 위치하도록 설정
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor) // 헤더의 하단으로부터 10 포인트 위에 위치하도록 설정
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}