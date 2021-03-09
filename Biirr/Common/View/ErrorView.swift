//
//  ErrorView.swift
//  Biirr
//
//  Created by Ana Márquez on 08/03/2021.
//

import UIKit

public class ErrorView {
    
    private var shadowView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    private var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()
    
    private var errorLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.font = UIFont.assingCustomFont(with: .semiBold, size: 16)
        v.numberOfLines = 4
        return v
    }()

    class var shared: ErrorView {
        struct Static {
            static let instance: ErrorView = ErrorView()
        }
        return Static.instance
    }

    init() {
        
        shadowView.addSubview(containerView)
        containerView.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: shadowView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: shadowView.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            errorLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            errorLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 20),
            errorLabel.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor,constant: -20),
        ])
    }

    public func showError(_ error: String, for duration: Double = 4) {
        guard let vc = UIApplication.getTopViewController() else { return }
        
        vc.view.addSubview(shadowView)
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(greaterThanOrEqualTo: vc.view.centerYAnchor, constant: 60),
            shadowView.leftAnchor.constraint(equalTo: vc.view.leftAnchor),
            shadowView.rightAnchor.constraint(equalTo: vc.view.rightAnchor),
            shadowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
        ])
        
        shadowView.applyShadow()
        
        self.errorLabel.text = error
        self.shadowView.reloadInputViews()
        
        self.hideOverlayView(at: duration)
    }

    private func hideOverlayView(at seconds: Double, completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            self.shadowView.delay(seconds) {
                self.shadowView.removeFromSuperview()
                completion?()
            }
        }
    }
}
