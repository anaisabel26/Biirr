//
//  ValidationType.swift
//  Biirr
//
//  Created by Ana Márquez on 08/03/2021.
//

import UIKit

enum ValidationType: String {
    case fullName
    case email
    case password
    case none
    
    var image: UIImage? {
        switch self {
        case .fullName: return UIImage(systemName: "person.circle")
        case .email: return UIImage(systemName: "envelope.circle")
        case .password: return UIImage(systemName: "lock.circle")
        default: return nil
        }
    }
    
    var secureText: Bool {
        switch self {
        case .password: return true
        default: return false
        }
    }
}
