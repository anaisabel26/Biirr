//
//  BeerTableViewCell.swift
//  Biirr
//
//  Created by Ana Márquez on 06/03/2021.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    //MARK: - View components
    
    private var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private var beerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.assingCustomFont(with: .semiBold, size: 16)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private var beerCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.assingCustomFont(with: .medium, size: 12)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    private var imageShadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private var beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder_grey")!
        return imageView
    }()
    
    //MARK: - Variables and Parameters
    
    var beer: Beer? {
        didSet { self.loadViews() }
    }
    
    var labelHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    private func setUpViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.addSubview(shadowView)
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            shadowView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            shadowView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
                ])
        
        self.shadowView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.shadowView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.shadowView.bottomAnchor),
            cardView.leftAnchor.constraint(equalTo: self.shadowView.leftAnchor),
            cardView.rightAnchor.constraint(equalTo: self.shadowView.rightAnchor)
                ])
    
        self.cardView.addSubview(imageShadowView)
        
        NSLayoutConstraint.activate([
            imageShadowView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            imageShadowView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 16),
            imageShadowView.heightAnchor.constraint(equalToConstant: 60),
            imageShadowView.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        self.imageShadowView.addSubview(beerImageView)
        
        NSLayoutConstraint.activate([
            beerImageView.topAnchor.constraint(equalTo: imageShadowView.topAnchor),
            beerImageView.bottomAnchor.constraint(equalTo: imageShadowView.bottomAnchor),
            beerImageView.leftAnchor.constraint(equalTo: imageShadowView.leftAnchor),
            beerImageView.heightAnchor.constraint(equalTo: imageShadowView.heightAnchor),
            beerImageView.widthAnchor.constraint(equalTo: imageShadowView.widthAnchor),
        ])
        
        self.cardView.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 22),
            labelsStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -22),
            labelsStackView.leftAnchor.constraint(equalTo: imageShadowView.rightAnchor, constant: 10),
            labelsStackView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -16),
        ])
        
        labelsStackView.addArrangedSubview(beerNameLabel)
        labelsStackView.addArrangedSubview(beerCategoryLabel)
        
        labelsStackView.spacing = 4
        labelsStackView.distribution = .fillProportionally
    }
    
    private func loadViews() {
        guard let beer = self.beer else { return }
        
        self.beerNameLabel.text = beer.displayName
        
        let beerCategoryName: String = beer.style?.category?.name ?? ""
        self.beerCategoryLabel.text = beerCategoryName.isEmpty ? "Unknowned" : beerCategoryName
        
        if let imageUrl = beer.labels?.iconImage, let url = URL(string: imageUrl) {
            self.beerImageView.downloadImage(from: url, placeholder: #imageLiteral(resourceName: "placeholder_grey"), roundCorner: 30)
        } else {
            self.beerImageView.makeRoundedAndShadowed(cornerRadius: 30)
        }
        
        self.imageShadowView.applyShadow(opacity: 0.1, shadowRadius: 30)
        self.beerImageView.clipsToBounds = true
        self.shadowView.applyShadow()
        self.cardView.roundCorners(radius: Size.largeCorner)
        self.reloadInputViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
