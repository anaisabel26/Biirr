//
//  CustomFont.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import Foundation
import UIKit

extension UIFont {
    
    enum PoppinsWeight {
        case regular, medium, semiBold, bold
        
        var fontName: String {
            switch self {
            case .regular: return "Poppins-Regular"
            case .medium: return "Poppins-Medium"
            case .semiBold: return "Poppins-SemiBold"
            case .bold: return "Poppins-Bold"
            }
        }
    }
    
    static func assingCustomFont(with weight: PoppinsWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.fontName, size: size)!
    }
}
