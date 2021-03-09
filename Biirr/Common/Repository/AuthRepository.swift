//
//  AuthRepository.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import Foundation
import FirebaseAuth

class AuthRepository {
    
    typealias completionHandler = (Result<AppUser, String>) -> Void
    
    private var auth: FirebaseAuth.Auth
    
    init() {
        self.auth = FirebaseAuth.Auth.auth()
    }
    
    func getCurrentUser(handler: @escaping completionHandler) {
        if let user = auth.currentUser {
            handler(.success(AppUser(id: user.uid, displayName: user.displayName ?? "", email: user.email)))
        } else {
            handler(.failure("Not session available"))
        }
    }
    
    func logOut(handler: @escaping completionHandler) {
        do {
            try self.auth.signOut()
            handler(.success(AppUser.empty))
        } catch (let error) {
            handler(.failure(error.localizedDescription))
        }
    }
    
    func logInWith(email: String, password: String, handler: @escaping completionHandler) {
        self.auth.signIn(withEmail: email, password: password) { (result, err) in
            if let err = err {
                handler(.failure(err.localizedDescription))
            } else if let result = result {
                handler(.success(AppUser(id: result.user.uid, displayName: result.user.displayName ?? "", email: result.user.email ?? email)))
            } else {
                handler(.failure("Log In was not possible"))
            }
        }
    }
    
    func registerUserWith(fullName: String, email: String, password: String, handler: @escaping completionHandler) {
        
        self.auth.createUser(withEmail: email, password: password) { (result, err) in
            if let err = err {
                handler(.failure(err.localizedDescription))
            } else if let _ = result {
                self.updateCurrentUserNameTo(fullName, handler: handler)
            } else {
                handler(.failure("Registration was not posible"))
            }
        }
    }
    
    private func updateCurrentUserNameTo(_ fullName: String, handler: @escaping completionHandler) {
        
        let changeRequest = self.auth.currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = fullName
        changeRequest?.commitChanges { (error) in
            
            guard let error = error else {
                handler(.success(AppUser(id: self.auth.currentUser?.uid ?? "", displayName: fullName, email: self.auth.currentUser?.email ?? "")))
                return
            }
            
            handler(.failure(error.localizedDescription))
        }
    }
}
