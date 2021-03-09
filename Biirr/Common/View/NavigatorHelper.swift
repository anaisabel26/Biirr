//
//  NavigatorHelper.swift
//  Biirr
//
//  Created by Ana Márquez on 08/03/2021.
//

import UIKit

class NavigatorHelper {
    
    static func pushToLogIn(from sender: UIViewController) {
        let vc = LogInViewController(LogInViewModel())
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true)
    }
    
    static func pushToSignUp(from sender: UIViewController) {
        let vc = SignUpViewController(SignUpViewModel())
        vc.modalPresentationStyle = .automatic
        sender.present(vc, animated: true)
    }
    
    static func pushToHome(from sender: UIViewController, user: AppUser) {
        
        let homeVC = HomeViewController(user)
        homeVC.modalTransitionStyle = .crossDissolve
        homeVC.modalPresentationStyle = .fullScreen
        sender.present(homeVC, animated: true)
    }
    
    static func pushToDetail(from sender: UIViewController, beer: Beer) {
        let vc = BeerDetailViewController(viewModel: BeerDetailViewModel(beer))
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        sender.present(vc, animated: true)
    }
}
