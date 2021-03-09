//
//  BeerDetailViewController.swift
//  Biirr
//
//  Created by Ana Márquez on 07/03/2021.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    // MARK: - Views
    private var backButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        b.imageEdgeInsets = UIEdgeInsets.zero
        b.backgroundColor = .clear
        b.tintColor = .black
        b.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return b
    }()
    
    private var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        return v
    }()
    
    private var contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var imageShadowView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    private var beerImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: "placeholder_grey")!
        v.roundCorners(radius: 50)
        v.clipsToBounds = true
        return v
    }()
    
    private var beerNameLabel: UILabel  = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 3
        v.font = UIFont.assingCustomFont(with: .bold, size: 20)
        v.textColor = .black
        return v
    }()
    
    private var lineView: UIView  = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()
    
    private var beerCategoryLabel: UILabel  = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 2
        v.font = UIFont.assingCustomFont(with: .regular, size: 14)
        v.textColor = .black
        return v
    }()
    
    private var detailStackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = 10
        return v
    }()
    
    private var organicView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.6823529412, green: 0.9019607843, blue: 0.4549019608, alpha: 1)
        return v
    }()
    
    private var organicLabel: UIView = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.assingCustomFont(with: .bold, size: 12)
        v.textColor = .white
        v.text = "ORGANIC"
        return v
    }()
    
    private var brewSheetLabel: UIView = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.assingCustomFont(with: .bold, size: 14)
        v.textColor = .black
        v.text = "BREW SHEET"
        return v
    }()
    
    private var informationStackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = 20
        return v
    }()
    
    private var percentageView: IconDetailSingleTextView = {
       let v = IconDetailSingleTextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var ibuView: IconDetailSingleTextView = {
        let v = IconDetailSingleTextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var descriptionTitle: UIView = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.assingCustomFont(with: .bold, size: 14)
        v.textColor = .black
        v.text = "DESCRIPTION"
        return v
    }()
    
    private var descriptionLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.sizeToFit()
        v.textColor = .black
        v.font = UIFont.assingCustomFont(with: .regular, size: 14)
        return v
    }()
    
    // MARK: - Variables and properties
    
    var viewModel: BeerDetailViewModel
    
    // MARK: - Initialization
    public init(viewModel: BeerDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        self.configureData()
    }
    
    // MARK: - SetUp
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        self.setUpScrollView()
        self.setUpScrollViewContent()
    }
    
    private func setUpScrollView() {
        self.view.addSubview(scrollView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.scrollView.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setUpScrollViewContent() {
        
        self.contentView.addSubview(imageShadowView)
        
        NSLayoutConstraint.activate([
            imageShadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageShadowView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            imageShadowView.heightAnchor.constraint(equalToConstant: 100),
            imageShadowView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        self.imageShadowView.addSubview(beerImageView)
        
        NSLayoutConstraint.activate([
            beerImageView.topAnchor.constraint(equalTo: imageShadowView.topAnchor),
            beerImageView.bottomAnchor.constraint(equalTo: imageShadowView.bottomAnchor),
            beerImageView.leftAnchor.constraint(equalTo: imageShadowView.leftAnchor),
            beerImageView.rightAnchor.constraint(equalTo: imageShadowView.rightAnchor),
        ])
        
        self.contentView.addSubview(beerNameLabel)
        
        NSLayoutConstraint.activate([
            beerNameLabel.topAnchor.constraint(equalTo: imageShadowView.topAnchor, constant: 16),
            beerNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            beerNameLabel.rightAnchor.constraint(equalTo: imageShadowView.leftAnchor, constant: -20)
        ])
        
        self.contentView.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: beerNameLabel.bottomAnchor, constant: 16),
            lineView.leftAnchor.constraint(equalTo: beerNameLabel.leftAnchor),
            lineView.widthAnchor.constraint(equalTo: beerNameLabel.widthAnchor, multiplier: 0.3),
            lineView.heightAnchor.constraint(equalToConstant: 2),
        ])
        
        self.contentView.addSubview(detailStackView)
        
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 30),
            detailStackView.leftAnchor.constraint(equalTo: lineView.leftAnchor),
            detailStackView.rightAnchor.constraint(equalTo: imageShadowView.leftAnchor, constant: -16)
        ])
        
        detailStackView.addArrangedSubview(beerCategoryLabel)
        detailStackView.addArrangedSubview(organicView)
        
        organicView.addSubview(organicLabel)
        
        NSLayoutConstraint.activate([
            organicView.heightAnchor.constraint(equalToConstant: 40),
            organicLabel.topAnchor.constraint(equalTo: organicView.topAnchor),
            organicLabel.bottomAnchor.constraint(equalTo: organicView.bottomAnchor),
            organicLabel.leftAnchor.constraint(equalTo: organicView.leftAnchor, constant: 16),
            organicLabel.rightAnchor.constraint(equalTo: organicView.rightAnchor),
        ])
        
        self.contentView.addSubview(brewSheetLabel)
        
        NSLayoutConstraint.activate([
            brewSheetLabel.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 30),
            brewSheetLabel.leftAnchor.constraint(equalTo: lineView.leftAnchor)
        ])
        
        self.contentView.addSubview(informationStackView)

        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: brewSheetLabel.bottomAnchor, constant: 30),
            informationStackView.leftAnchor.constraint(equalTo: lineView.leftAnchor),
            informationStackView.rightAnchor.constraint(equalTo: contentView.leftAnchor),
        ])

        self.informationStackView.addArrangedSubview(percentageView)
        self.informationStackView.addArrangedSubview(ibuView)
        
        self.contentView.addSubview(descriptionTitle)

        NSLayoutConstraint.activate([
            descriptionTitle.topAnchor.constraint(equalTo: informationStackView.bottomAnchor, constant: 30),
            descriptionTitle.leftAnchor.constraint(equalTo: informationStackView.rightAnchor),
            descriptionTitle.rightAnchor.constraint(equalTo: beerImageView.rightAnchor),
        ])

        self.contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 30),
            descriptionLabel.leftAnchor.constraint(equalTo: informationStackView.rightAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: beerImageView.rightAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30)
        ])
    }
    
    private func configureData() {
        let beer = self.viewModel.beer.value
        let categoryName = beer.style?.category?.name ?? ""
        
        self.beerNameLabel.text = beer.displayName
        
        self.beerCategoryLabel.text = categoryName.isEmpty ? "" : categoryName.capitalized
        self.beerCategoryLabel.isHidden = categoryName.isEmpty
        
        self.organicView.roundCorners()
        self.organicView.isHidden = !beer.isOrganic
        
        if let string = self.viewModel.beer.value.labels?.largeIconImage ?? self.viewModel.beer.value.labels?.iconImage, let url = URL(string: string) {
            self.beerImageView.downloadImage(from: url, placeholder: #imageLiteral(resourceName: "placeholder_grey"), roundCorner: 50)
        }
        
        self.imageShadowView.applyShadow()
        
        if let percentage = beer.abv {
            percentageView.updateValues(title: "ABV:", information: "\(percentage)%", icon: #imageLiteral(resourceName: "percentage_icon"))
            percentageView.isHidden = false
        } else {
            percentageView.isHidden = true
        }

        if let bitter = beer.bitter {
            ibuView.updateValues(title: "Bitter:", information: "\(bitter)", icon: #imageLiteral(resourceName: "ibu_icon"))
            ibuView.isHidden = false
        } else {
            ibuView.isHidden = true
        }
        
        self.descriptionLabel.text = beer.style?.description ?? "Not available"
        
        self.view.reloadInputViews()
    }
    
    // MARK: - Actions
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
}
