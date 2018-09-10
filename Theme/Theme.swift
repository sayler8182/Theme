//
//  Theme.swift
//  Theme
//
//  Created by Konrad on 10/09/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import UIKit

@objc protocol Themeable: Weakable {
    @objc func updateTheme(_ theme: Theme)
}

@objc protocol Theme {
    var primaryColor: UIColor       { get }
    var secondaryColor: UIColor     { get }
    var textColor: UIColor          { get }
}

class ThemeManager {
    static var shared: ThemeManager = ThemeManager()
    
    fileprivate (set) var currentTheme: Theme = LightTheme()
    fileprivate var themeables: [Weak<Themeable>] = []
     
    // update theme
    func updateTheme(_ theme: Theme) {
        self.currentTheme = theme
        self.themeables = self.themeables.filter { !$0.isNil }
        for themeable in themeables {
            themeable.value?.updateTheme(self.currentTheme)
        }
    }
    
    // add observer
    func add(_ themeable: Themeable, forceUpdate: Bool = false) {
        self.themeables = self.themeables.filter { !$0.isNil }
        self.themeables.append(Weak(value: themeable))
        
        // perform update
        if forceUpdate {
            themeable.updateTheme(self.currentTheme)
        }
    }
    
    // remove
    func remove(_ themeable: Themeable) {
        self.themeables = self.themeables.filter {
            $0.value?.isEqual(themeable) == false
        }
    }
}

class LightTheme: Theme {
    var primaryColor: UIColor       = UIColor(red: 1.00, green: 0.52, blue: 0.52, alpha: 1.0)
    var secondaryColor: UIColor     = UIColor(red: 0.52, green: 1.00, blue: 0.52, alpha: 1.0)
    var textColor: UIColor          = UIColor.black
}

class DarkTheme: Theme {
    var primaryColor: UIColor       = UIColor(red: 0.82, green: 0.02, blue: 0.02, alpha: 1.0)
    var secondaryColor: UIColor     = UIColor(red: 0.00, green: 0.60, blue: 0.00, alpha: 1.0)
    var textColor: UIColor          = UIColor.white
}
