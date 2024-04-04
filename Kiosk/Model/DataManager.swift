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
        let macBook = [
            AppleProduct(image: UIImage(named: "macBook"), name: "macBook Pro", price: 2000000, category: "맥북", value: 1),
            AppleProduct(image: UIImage(named: "macBook"), name: "macBook Pro2", price: 2000000, category: "맥북", value: 1),
            AppleProduct(image: UIImage(named: "macBook"), name: "macBook Pro2", price: 2000000, category: "맥북", value: 1),
            AppleProduct(image: UIImage(named: "macBook"), name: "macBook Pro2", price: 2000000, category: "맥북", value: 1)
        ]
        
        let iPhone = [
            AppleProduct(image: UIImage(named: "iPhone"), name: "iPhone 12", price: 1000000, category: "아이폰", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "iPhone 12", price: 1000000, category: "아이폰", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "iPhone 12", price: 1000000, category: "아이폰", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "iPhone 12", price: 1000000, category: "아이폰", value: 1)
        ]
        
        let iPad = [
            AppleProduct(image: UIImage(named: "iPhone"), name: "iPad Pro", price: 800000, category: "패드", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "iPad Pro", price: 800000, category: "패드", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "iPad Pro", price: 800000, category: "패드", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "iPad Pro", price: 800000, category: "패드", value: 1)
        ]
        
        let appleWatch = [
            AppleProduct(image: UIImage(named: "iPhone"), name: "Apple Watch Series 6", price: 500000, category: "워치", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "Apple Watch Series 6", price: 500000, category: "워치", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "Apple Watch Series 6", price: 500000, category: "워치", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "Apple Watch Series 6", price: 500000, category: "워치", value: 1)
        ]
        
        let etcAccessory = [
            AppleProduct(image: UIImage(named: "iPhone"), name: "AirPods Pro", price: 300000, category: "악세사리", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "AirPods Pro", price: 300000, category: "악세사리", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "AirPods Pro", price: 300000, category: "악세사리", value: 1),
            AppleProduct(image: UIImage(named: "iPhone"), name: "AirPods Pro", price: 300000, category: "악세사리", value: 1)
        ]
        
        products.append(contentsOf: macBook)
        products.append(contentsOf: iPhone)
        products.append(contentsOf: iPad)
        products.append(contentsOf: appleWatch)
        products.append(contentsOf: etcAccessory)
    }
}


// MARK: - HOME 데이터

class HomeDataManager {
    static func generateDummyData() -> [HomeItem] {
        return [
            HomeItem(imageName: "homeImage7"),
            HomeItem(imageName: "homeImage3"),
            HomeItem(imageName: "homeImage1"),
            HomeItem(imageName: "homeImage4"),
            HomeItem(imageName: "homeImage5"),
            HomeItem(imageName: "homeImage6"),
            HomeItem(imageName: "homeImage2")
        ]
    }
}
