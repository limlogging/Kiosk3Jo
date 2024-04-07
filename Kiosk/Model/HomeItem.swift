//
//  HomeItem.swift
//  Kiosk
//
//  Created by Dongik Song on 4/4/24.
//

import UIKit
import Foundation

// MARK: - Home 데이터
struct HomeItem {
    let image: UIImage
    
    init(imageName: String) {
        self.image = UIImage(named: imageName)!
    }
}
