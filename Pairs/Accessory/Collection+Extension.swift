//
//  Collection+Extension.swift
//  Pairs
//
//  Created by Yury on 21/04/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import Foundation


extension Collection {
    
    var oneAndOnly: Element? {
        return self.count == 1 ? first : nil
    }
    
}

