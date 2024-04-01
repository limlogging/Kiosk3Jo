//
//  ProductCell.swift
//  Kiosk
//
//  Created by 김시종 on 4/1/24.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func configure(with product: AppleProduct) {
        productImage.image = product.image
        productLabel.text = product.name
        productPrice.text = "\(product.price)"
    }
    
    
}



