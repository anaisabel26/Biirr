//
//  SignUpViewController.swift
//  Biirr
//
//  Created by Ana Márquez on 06/03/2021.
//

import UIKit

class SignUpViewController: UIViewController {

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
        label.text = "Already have an account?"
        label.font = UIFont.assingCustomFont(with: .regular, size: 14)
        label.textAlignment = .right
        return label
    }()
    
    private var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.assingCustomFont(with: .semiBold, size: 14)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //Mark: - Textfields
    private var fullNameTF: BiirrTextField = {
        let textField = BiirrTextField()
        textField.validationType = .fullName
        textField.placeholder = "Full Name"
        textField.keyboardType = .default
        textField.addLeftIcon()
        return textField
    }()
    
    private var emailTF: BiirrTextField = {
        let textField = BiirrTextField()
        textField.validationType = .email
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.addLeftIcon()
        return textField
    }()
    
    private var passwordTF: BiirrTextField = {
        let textField = BiirrTextField()
        textField.validationType = .password
        textField.placeholder = "Password"
        textField.keyboardType = .emailAddress
        textField.addLeftIcon()
        return textField
    }()
    
    //Mark: - Buttons
    private var signUpButton: BiirButton = {
       let button = BiirButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "darkOrangeColor")!
        button.roundCorners()
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    //MARK: - Variables and Properties
    
    var textValidation = TextValidationModel()
    
    var viewModel: SignUpViewModel
    
    init(_ viewModel: SignUpViewModel) {
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
        view.backgroundColor = UIColor.white
        view.addSubview(logInFormStackView)
        
        logInFormStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -65).isActive = true
        logInFormStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50).isActive = true
        logInFormStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50).isActive = true

        logInFormStackView.addArrangedSubview(logoImageView)
        logInFormStackView.addArrangedSubview(fullNameTF)
        logInFormStackView.addArrangedSubview(emailTF)
        logInFormStackView.addArrangedSubview(passwordTF)
        logInFormStackView.addArrangedSubview(signUpButton)
        
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        logInFormStackView.spacing = 20
        logInFormStackView.setCustomSpacing(60, after: logoImageView)
        logInFormStackView.setCustomSpacing(40, after: passwordTF)
        
        fullNameTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bottomStackView)

        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        bottomStackView.addArrangedSubview(informationLabel)
        bottomStackView.addArrangedSubview(logInButton)
    }
    
    private func configureTextValidation() {
        self.emailTF.delegate = self.textValidation
        self.passwordTF.delegate = self.textValidation
        self.fullNameTF.delegate = self.textValidation
        
        self.textValidation.data.addAndNotify(observer: self) { [weak self] in
            
            self?.view.endEditing(true)
            self?.viewModel.updateValue(data: self?.textValidation.data.value ?? [:])
        }
        
        self.viewModel.isSubmitAllow.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.signUpButton.isEnabled = self?.viewModel.isSubmitAllow.value ?? false
            }
        }
        
        self.viewModel.appUser.addAndNotify(observer: self) { [weak self] in
            guard let user = self?.viewModel.appUser.value, let vc = self else { return }
            
            NavigatorHelper.pushToHome(from: vc, user: user)
        }
    }
    
    @objc func signUpButtonTapped() {
        self.viewModel.register()
    }
    
    @objc func loginButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
