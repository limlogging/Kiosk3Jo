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
    var isNew: Bool
}


// MARK: - 고객센터 데이터
struct Menu {
    let title: String
    let leftImage: String?
    let rightImage: String?
}
