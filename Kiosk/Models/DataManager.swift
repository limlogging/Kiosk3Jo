//
//  DataManager.swift
//  Kiosk
//
//  Created by 김시종 on 4/1/24.
//

import UIKit


class DataManager {
    var products: [AppleProduct] = []
    
    init() {
        let macBook = AppleProduct(image: UIImage(named: "macBook"), name: "macBook Pro", price: 2000000, category: "맥북")
        let iPhone = AppleProduct(image: UIImage(named: "macBook"), name: "iPhone 12", price: 1000000, category: "아이폰")
        let iPad = AppleProduct(image: UIImage(named: "macBook"), name: "iPad Pro", price: 800000, category: "패드")
        let appleWatch = AppleProduct(image: UIImage(named: "macBook"), name: "Apple Watch Series 6", price: 500000, category: "워치")
        let etcAccessory = AppleProduct(image: UIImage(named: "macBook"), name: "AirPods Pro", price: 300000, category: "악세사리")

        products = [macBook, iPhone, iPad, appleWatch, etcAccessory]
    }
}


