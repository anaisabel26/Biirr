//
//  MoreBeerTableViewCell.swift
//  Biirr
//
//  Created by Ana Márquez on 07/03/2021.
//

import UIKit

class MoreBeerTableViewCell: UITableViewCell {
    
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
    
    private var loadMoreLabel: UIView = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.assingCustomFont(with: .semiBold, size: 16)
        label.text = "Load more beers"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.927017808, green: 0.3544298708, blue: 0.1428053975, alpha: 1)
        return label
    }()
    
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
        
        self.shadowView.applyShadow()
        self.cardView.roundCorners(radius: Size.largeCorner)
        
        self.cardView.addSubview(loadMoreLabel)
        
        NSLayoutConstraint.activate([
            loadMoreLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            loadMoreLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
            loadMoreLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
        ])
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
