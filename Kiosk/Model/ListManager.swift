//
//  ListManager.swift
//  Kiosk
//
//  Created by Dongik Song on 4/5/24.
//

import Foundation

class ListManager {
    
    static let shared = ListManager()
    
    var list: [AppleProduct] = []
    
    private init () {}
    
}
