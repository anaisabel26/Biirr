//
//  BiirTextField.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import UIKit

class BiirrTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var tintColor: UIColor! {
        didSet { setNeedsDisplay() }
    }
    
    var validationType: ValidationType = .none
    var borderLineColor: UIColor = #colorLiteral(red: 0.9681808352, green: 0.6184259653, blue: 0.1415834725, alpha: 1)
    var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            self.setplaceHolderColor()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)

        let path = UIBezierPath()

        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 2.0

        tintColor.setStroke()

        path.stroke()
    }
    
    func commonInit() {
        self.placeholderColor = UIColor.lightGray
        self.tintColor = UIColor.lightGray
        self.isSecureTextEntry = validationType.secureText
    }
    
    func addLeftIcon() {
        if let icon = self.validationType.image {
            self.leftViewMode = UITextField.ViewMode.always
            let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            iconView.image = icon
            iconView.tintColor = UIColor.lightGray
            iconView.contentMode = .scaleAspectFit

            let iconContainerView: UIView = UIView(frame:
                          CGRect(x: 0, y: 0, width: 30, height: 30))
            iconContainerView.addSubview(iconView)
            iconView.center = iconContainerView.center

            self.leftView = iconContainerView
        }
    }
    
    private func setplaceHolderColor() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
}
