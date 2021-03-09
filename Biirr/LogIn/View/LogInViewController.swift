//
//  LogInViewController.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //Mark: - Views
    private let logoImageView : UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = #imageLiteral(resourceName: "biirr_logo")
        v.contentMode = .scaleAspectFit
        
        return v
    }()
    
    private let logInFormStackView : UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        return v
    }()
    
    private let bottomStackView : UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.spacing = 5
        v.distribution = .fillProportionally
        return v
    }()
    
    private var informationLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont.assingCustomFont(with: .regular, size: 14)
        label.textAlignment = .right
        return label
    }()
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sing Up", for: .normal)
        button.titleLabel?.font = UIFont.assingCustomFont(with: .semiBold, size: 14)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //Mark: - Textfields
    private var emailTF: BiirrTextField = {
        let textField = BiirrTextField()
        textField.validationType = .email
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.font = UIFont.assingCustomFont(with: .regular, size: 14)
        textField.addLeftIcon()
        return textField
    }()
    
    private var passwordTF: BiirrTextField = {
        let textField = BiirrTextField()
        textField.validationType = .password
        textField.placeholder = "Password"
        textField.keyboardType = .emailAddress
        textField.font = UIFont.assingCustomFont(with: .regular, size: 14)
        textField.addLeftIcon()
        return textField
    }()
    
    //Mark: - Buttons
    private var loginButton: BiirButton = {
        let button = BiirButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "darkOrangeColor")!
        button.roundCorners()
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    //MARK: - Variables and Properties
    
    var textValidation = TextValidationModel()
    
    var viewModel: LogInViewModel
    
    init(_ viewModel: LogInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.hideKeyboardWhenTappedAround()
        self.configureTextValidation()
    }
    
    //MARK: - View Config
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logInFormStackView)
        
        logInFormStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -65).isActive = true
        logInFormStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50).isActive = true
        logInFormStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50).isActive = true
        
        logInFormStackView.addArrangedSubview(logoImageView)
        logInFormStackView.addArrangedSubview(emailTF)
        logInFormStackView.addArrangedSubview(passwordTF)
        logInFormStackView.addArrangedSubview(loginButton)
        
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        logInFormStackView.spacing = 20
        logInFormStackView.setCustomSpacing(60, after: logoImageView)
        logInFormStackView.setCustomSpacing(40, after: passwordTF)
        
        emailTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bottomStackView)
        
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        bottomStackView.addArrangedSubview(informationLabel)
        bottomStackView.addArrangedSubview(signUpButton)
    }
    
    private func configureTextValidation() {
        self.emailTF.delegate = self.textValidation
        self.passwordTF.delegate = self.textValidation
        
        self.textValidation.data.addAndNotify(observer: self) { [weak self] in
            
            self?.view.endEditing(true)
            self?.viewModel.updateValue(data: self?.textValidation.data.value ?? [:])
        }
        
        self.viewModel.isSubmitAllow.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = self?.viewModel.isSubmitAllow.value ?? false
            }
        }
        
        self.viewModel.appUser.addAndNotify(observer: self) { [weak self] in
            guard let user = self?.viewModel.appUser.value, let vc = self else { return }
            
            NavigatorHelper.pushToHome(from: vc, user: user)
        }
    }
    
    @objc func loginButtonTapped() {
        self.viewModel.login()
    }
    
    @objc func signUpButtonTapped() {
        NavigatorHelper.pushToSignUp(from: self)
    }
}
