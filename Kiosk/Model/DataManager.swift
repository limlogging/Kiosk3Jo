//
//  DataManager.swift
//  Kiosk
//
//  Created by Dongik Song on 4/6/24.
//

import UIKit

class DataManager {
    var products: [AppleProduct] = []
    
    init() {
        let macBook = [
            AppleProduct(image: UIImage(named: "MacBookAir13(M2)"), name: "MacBook Air13(M2)", price: 1390000, category: "맥북", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MacBookAir13(M2)"), name: "MacBook Air13(M3)", price: 1590000, category: "맥북", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "MacBookAir15(M3)"), name: "MacBook Air15(M3)", price: 1890000, category: "맥북", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "MacBookPro14"), name: "MacBook Pro14", price: 2390000, category: "맥북", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MacBookPro14"), name: "MacBook Pro16", price: 3690000, category: "맥북", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "iMac"), name: "iMac", price: 1990000, category: "맥북", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MacMini"), name: "Mac mini", price: 850000, category: "맥북", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MacPro"), name: "Mac Pro", price: 10490000, category: "맥북", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MacStudio"), name: "Mac Studio", price: 2990000, category: "맥북", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "StudioDisplay"), name: "Studio Display", price: 2090000, category: "맥북", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "ProDisplayXDR"), name: "Pro Display XDR", price: 6499000, category: "맥북", value: 1, isNew: false)
        ]
        
        let iPhone = [
            AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "iPhone 15 Pro", price: 1550000, category: "아이폰", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "iPhone 15 Pro Max", price: 1900000, category: "아이폰", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "iPhone15Plus"), name: "iPhone 15", price: 1250000, category: "아이폰", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "iPhone15Plus"), name: "iPhone 15 Plus", price: 1350000, category: "아이폰", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "iPhone14Plus"), name: "iPhone 14", price: 1090000, category: "아이폰", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "iPhone14Plus"), name: "iPhone 14 Plus", price: 1250000, category: "아이폰", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "iPhone13"), name: "iPhone 13", price: 950000, category: "아이폰", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "iPhoneSE"), name: "iPhone SE", price: 650000, category: "아이폰", value: 1, isNew: false)
        ]
        
        let iPad = [
            AppleProduct(image: UIImage(named: "iPadPro11"), name: "iPad Pro 11", price: 1249000, category: "패드", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "iPadPro12.9"), name: "iPad Pro 12.9", price: 1729000, category: "패드", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "iPadAir"), name: "iPad Air", price: 929000, category: "패드", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "iPad(10thGeneration)"), name: "iPad(10세대)", price: 679000, category: "패드", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "iPad(9thGeneration)"), name: "iPad(9세대)", price: 499000, category: "패드", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "iPadMini"), name: "iPad mini", price: 769000, category: "패드", value: 1, isNew: false)
        ]
        
        let appleWatch = [
            AppleProduct(image: UIImage(named: "AppleWatchSeries9"), name: "Apple Watch Series 9", price: 599000, category: "워치", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "AppleWatchUltra2"), name: "Apple Watch Ultra 2", price: 1149000, category: "워치", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "AppleWatchSE"), name: "Apple Watch SE", price: 329000, category: "워치", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "AppleWatchHermes"), name: "Apple Watch Hermès", price: 1699000, category: "워치", value: 1, isNew: false)
        ]
        
        let etcAccessory = [
            AppleProduct(image: UIImage(named: "MagSafeiPhone15SiliconeCase"), name: "iPhone 실리콘 케이스", price: 69000, category: "악세사리", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "MacSafeiPhone15ProClearCase"), name: "iPhone 투명 케이스", price: 69000, category: "악세사리", value: 1, isNew: true),
            AppleProduct(image: UIImage(named: "20WUSB-CpowerAdapter"), name: "USB-C 어댑터", price: 28000, category: "악세사리", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MacSafeiPhoneFineWovenWallet"), name: "iPhone 카드지갑", price: 85000, category: "악세사리", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MilaneseLoop"), name: "밀레니즈 루프", price: 135000, category: "악세사리", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "Keyboard"), name: "Keyboard", price: 229000, category: "악세사리", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MagicMouse"), name: "Magic Mouse", price: 119000, category: "악세사리", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "MagicTrackpad"), name: "Magic Trackpad", price: 175000, category: "악세사리", value: 1, isNew: false),
            AppleProduct(image: UIImage(named: "AirTag"), name: "AirTag", price: 45000, category: "악세사리", value: 1, isNew: false)
        ]
        
        products.append(contentsOf: macBook)
        products.append(contentsOf: iPhone)
        products.append(contentsOf: iPad)
        products.append(contentsOf: appleWatch)
        products.append(contentsOf: etcAccessory)
    }
}
