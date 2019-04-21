//
//  Int+Extension.swift
//  Pairs
//
//  Created by Yury on 21/04/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import Foundation


extension Int {
    
    var randomLessNumber: Int {
        return Int.random(in: 0..<self) * (self >= 0 ? 1 : -1)
    }
    
}
