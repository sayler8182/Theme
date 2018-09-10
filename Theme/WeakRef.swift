//
//  WeakRef.swift
//  Theme
//
//  Created by Konrad on 10/09/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation

@objc protocol Weakable: class, NSObjectProtocol { }

class Weak<T: Weakable> {
    private (set) weak var value: T?
    
    var isNil: Bool {
        return self.value == nil
    }
    
    init(value: T?) {
        self.value = value
    }
} 
