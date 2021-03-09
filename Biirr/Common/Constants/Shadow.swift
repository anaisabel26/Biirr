//
//  Shadow.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import UIKit

struct Shadow {
    static var color: UIColor { return UIColor(named: "shadowColor")! }
    static var offset: CGSize { return CGSize(width: 2, height: 5) }
    static var radius: CGFloat { return 10 }
    static var opacity: Float { return 0.2 }
}
