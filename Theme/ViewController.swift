//
//  ViewController.swift
//  Theme
//
//  Created by Konrad on 10/09/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var firstView: CustomView   = CustomView()
    fileprivate var secondView: UIView      = UIView()
    fileprivate lazy var toggleButton: UIButton = {
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 44))
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.black
        button.contentEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 16)
        button.setTitle("Toggle", for: UIControlState.normal)
        button.addTarget(self, action: #selector(toggleClick(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.firstView)
        self.view.addSubview(self.secondView)
        self.view.addSubview(self.toggleButton)
        
        // register theme
        ThemeManager.shared.add(self, forceUpdate: true)
    }
    
    @objc func toggleClick(_ sender: UIButton) {
        if ThemeManager.shared.currentTheme is LightTheme {
            ThemeManager.shared.updateTheme(DarkTheme())
        } else {
            ThemeManager.shared.updateTheme(LightTheme())
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width: CGFloat = self.view.frame.width
        let height: CGFloat = self.view.frame.height / 2
        self.firstView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.secondView.frame = CGRect(x: 0, y: height, width: width, height: height)
        self.toggleButton.center = self.view.center
    }
}

// MARK: Themeable
extension ViewController: Themeable {
    func updateTheme(_ theme: Theme) {
        self.secondView.backgroundColor = theme.secondaryColor
        
        if theme is LightTheme {
            self.toggleButton.setTitle("Toggle to dark", for: UIControlState.normal)
        } else {
            self.toggleButton.setTitle("Toggle to light", for: UIControlState.normal)
        }
    }
}
