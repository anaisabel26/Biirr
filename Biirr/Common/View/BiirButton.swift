//
//  BiirButton.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import UIKit

class BiirButton: UIButton {
    
    var title: String?
    var mainColor: UIColor = #colorLiteral(red: 0.9681808352, green: 0.6184259653, blue: 0.1415834725, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? self.mainColor : UIColor.lightGray
        }
    }
    
    private func commonInit() {
        layer.masksToBounds = true
        
        let text = CATextLayer()
        text.font = UIFont.assingCustomFont(with: .medium, size: 20)
        text.frame = bounds
        text.string = title
        text.alignmentMode = .center
        text.anchorPoint = CGPoint(x: 0.5, y: 0.3)
        text.foregroundColor = UIColor.white.cgColor
        layer.insertSublayer(text, at: 1)
    }
}
