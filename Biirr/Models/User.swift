//
//  User.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import Foundation

struct AppUser: Equatable {
    var id: String?
    var displayName: String?
    var email: String?
    
    static var empty: AppUser {
        return AppUser(id: nil, displayName: nil, email: nil)
    }
    
    static func == (lhs: AppUser, rhs: AppUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(id: String?, displayName: String?, email: String?) {
        self.id = id
        self.displayName = displayName
        self.email = email
    }
}
