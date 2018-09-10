//
//  CustomView.swift
//  Theme
//
//  Created by Konrad on 10/09/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import UIKit

class CustomView: UIView {
    fileprivate lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "This is custom view"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepareView()
    }
    
    // preapre view
    fileprivate func prepareView() {
        self.addSubview(self.titleLabel)
        
        // register theme
        ThemeManager.shared.add(self, forceUpdate: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.frame = self.bounds
    }
}

// MARK: Themeable
extension CustomView: Themeable {
    func updateTheme(_ theme: Theme) {
        self.backgroundColor = theme.primaryColor
        self.titleLabel.textColor = theme.textColor
    }
}
