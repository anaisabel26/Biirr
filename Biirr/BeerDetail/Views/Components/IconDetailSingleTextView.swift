//
//  IconDetailStackView.swift
//  Biirr
//
//  Created by Ana Márquez on 07/03/2021.
//

import UIKit

class IconDetailSingleTextView: UIView {
    
    //MARK: - Views
    
    private var iconImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.assingCustomFont(with: .regular, size: 16)
        v.textColor = .black
        return v
    }()
    
    private var informationLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.assingCustomFont(with: .regular, size: 16)
        v.textColor = .black
        return v
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //MARK: - SetUp
    
    private func setUpUI() {
        self.backgroundColor = .clear
        
        self.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 70),
        ])
        
        self.addSubview(informationLabel)
        
        NSLayoutConstraint.activate([
            informationLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            informationLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10),
        ])
    }
    
    func updateValues(title: String, information: String, icon: UIImage) {
        self.titleLabel.text = title
        self.informationLabel.text = information
        self.iconImageView.image = icon
        self.reloadInputViews()
    }
}
