//
//  SessionViewModel.swift
//  Biirr
//
//  Created by Ana Márquez on 07/03/2021.
//

import UIKit

class LogInViewModel {
    
    var authRepository: AuthRepository
    
    var emailText: String = ""
    var passwordText: String = ""
    
    var isSubmitAllow: DynamicValue<Bool> = DynamicValue(false)
    
    var appUser: DynamicValue<AppUser?> = DynamicValue(AppUser.empty)
    
    var error: String? = nil {
        didSet {
            guard let err = self.error else { return }
            ErrorView.shared.showError(err)
        }
    }
    
    init() {
        self.authRepository = AuthRepository()
    }
    
    func login() {
        guard validFormForLogin(email: emailText, password: passwordText) else { return }
        
        LoadingView.shared.showOverlay(gif: .fill)
        
        self.authRepository.logInWith(email: emailText, password: passwordText) { (result) in
            
            switch result {
            case .success(let user):
                LoadingView.shared.hideOverlayView {
                    self.appUser.value = user
                }
            case .failure(let err):
                LoadingView.shared.hideOverlayView {
                    self.error = err
                }
            }
        }
    }
    
    func updateValue(data: [String: String?]) {
        if let email = data["email"] {
            self.emailText = email ?? ""
        }
        
        if let password = data["password"] {
            self.passwordText = password ?? ""
        }
        
        self.isSubmitAllow.value = !emailText.isEmpty && !passwordText.isEmpty
    }
    
    private func validFormForLogin(email: String, password: String) -> Bool {
        guard email.isValidEmail() else {
            self.error = "Invalid email"
            return false
        }
        
        guard password.isValidPassword() else {
            self.error = "Invalid password"
            return false
        }
        
        return true
    }
}
