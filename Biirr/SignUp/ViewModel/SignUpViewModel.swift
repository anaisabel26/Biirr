//
//  SignUpViewModel.swift
//  Biirr
//
//  Created by Ana Márquez on 08/03/2021.
//

import Foundation

class SignUpViewModel {
    
    var authRepository: AuthRepository
    
    var emailText: String = ""
    var passwordText: String = ""
    var fullNameText: String = ""
    
    var isSubmitAllow: DynamicValue<Bool> = DynamicValue(false)
    
    var appUser: DynamicValue<AppUser?> = DynamicValue(AppUser.empty)
    
    var error: String? = nil {
        didSet {
            guard let err = error else { return }
            ErrorView.shared.showError(err)
        }
    }
    
    init() {
        self.authRepository = AuthRepository()
    }
    
    func register() {
        guard validFormForRegister(fullname: fullNameText, email: emailText, password: passwordText) else { return }
        
        LoadingView.shared.showOverlay(gif: .fill)
        
        self.authRepository.registerUserWith(fullName: fullNameText, email: emailText, password: passwordText) { (result) in
            
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
        
        if let fullName = data["fullName"] {
            self.fullNameText = fullName ?? ""
        }
        
        self.isSubmitAllow.value = !emailText.isEmpty && !passwordText.isEmpty && !fullNameText.isEmpty
    }
    
    private func validFormForRegister(fullname: String, email: String, password: String) -> Bool {
        guard !fullname.isEmpty else {
            self.error = "Full name field shouldn't be empty"
            return false
        }
        
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
