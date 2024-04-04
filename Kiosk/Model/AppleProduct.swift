//
//  AppleProduct.swift
//  Kiosk
//
//  Created by imhs on 4/3/24.
//

import Foundation
import UIKit

struct AppleProduct {
    let image: UIImage?
    let name: String
    let price: Int
    let category: String
    var value: Int 
}


// MARK: - Home 데이터
struct HomeItem {
    let image: UIImage
    
    init(imageName: String) {
        self.image = UIImage(named: imageName)!
    }
}


// MARK: - 고객센터 데이터
struct Menu {
    let title: String
    let leftImage: String?
    let rightImage: String?
}

