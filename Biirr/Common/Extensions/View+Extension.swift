//
//  View+Extension.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import UIKit

extension UIView {
    func delay(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    func roundCorners(radius: CGFloat = Size.standardCorner) {
        DispatchQueue.main.async {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat = Size.largeCorner) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func applyShadow(color: UIColor = Shadow.color, opacity: Float = Shadow.opacity, offset: CGSize = Shadow.offset, shadowRadius: CGFloat = Shadow.radius) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
    
    func makeRoundedAndShadowed(cornerRadius: CGFloat = Size.largeCorner, shadowColor: UIColor = Shadow.color, opacity: Float = Shadow.opacity, offset: CGSize = Shadow.offset, shadowRadius: CGFloat = Shadow.radius) {
        let shadowLayer = CAShapeLayer()
        
        self.layer.cornerRadius = cornerRadius
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds,
                                        cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
