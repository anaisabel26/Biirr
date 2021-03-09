//
//  ViewController.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var repository: AuthRepository = AuthRepository()
    
    private var logoImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = #imageLiteral(resourceName: "biirr_logo")
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.initializeUser()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 128),
            logoImageView.widthAnchor.constraint(equalToConstant: 240),
        ])
    }
    
    private func initializeUser() {
        self.repository.getCurrentUser { (result) in
            
            switch result {
            case .success(let appUser):
                NavigatorHelper.pushToHome(from: self, user: appUser)
            case .failure(_):
                NavigatorHelper.pushToLogIn(from: self)
                let vc = LogInViewController(LogInViewModel())
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
}

