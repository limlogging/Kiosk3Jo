//
//  MyPageCartTableViewCell.swift
//  Kiosk
//
//  Created by imhs on 4/5/24.
//

import UIKit

class MyPageCartTableViewCell: UITableViewCell {
    // MARK: - 상품이미지
    var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - 상품명
    var productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 상품가격
    var productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 상품수량
    var productValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productInfoStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [productName, productPrice, productValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = -5
        return stackView
    }()
    
    /* Interface Builder (스토리보드 또는 xib 파일)에서 로드될 때 호출되는 메서드이므로 코드로만 작성하는 경우 호출되지 않아 주석처리 가능
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    */
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - 초기화 메서드 오버라이드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellUI() {
        //Cell에 추가
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(productValue)
        contentView.addSubview(productInfoStackView)
                
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            productImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            productName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productName.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 5),
            
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 1),
            productPrice.leadingAnchor.constraint(equalTo: productName.leadingAnchor),
            
            productValue.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 1),
            productValue.leadingAnchor.constraint(equalTo: productName.leadingAnchor),
            
            productInfoStackView.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 5),
            productInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            productInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }
}
