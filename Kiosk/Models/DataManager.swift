//
//  DataManager.swift
//  Kiosk
//
//  Created by 김시종 on 4/1/24.
//

import UIKit


class DataManager {
    var MacArray: [Mac] = []
    var IphoneArray: [Iphone] = []
    var IpadArray: [Ipad] = []
    var WatchArray: [Watch] = []
    var EtcArray: [Etc] = []
    
    func makeProductData() {
        MacArray = [Mac(title: "Mac", description: "test", price: 1000000),
                    Mac(title: "test", description: "test", price: 1300000)]
        
        IphoneArray = [Iphone(title: "Iphone", description: "test", price: 10000000)]
        
        IpadArray = [Ipad(title: "Ipad", description: "test", price: 10900000)]
        
        WatchArray = [Watch(title: "Watch", description: "test", price: 10900000)]
        
        EtcArray = [Etc(title: "Etc", description: "test", price: 10900000)]
    }
    
}
