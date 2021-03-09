//
//  HomeViewController.swift
//  Biirr
//
//  Created by Ana Márquez on 06/03/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - View Components
    
    var navBarBackgroundView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "beer_bg_2")
        view.contentMode = .scaleToFill
        return view
    }()

    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.assingCustomFont(with: .bold, size: 30)
        label.textColor = .white
        return label
    }()
    
    var profileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        //"person.crop.circle"
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets.zero
        button.backgroundColor = .clear
        button.tintColor = .white
        button.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        return button
    }()
    
    var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.separatorColor = .clear
        tv.register(BeerTableViewCell.self, forCellReuseIdentifier: "BeerCell")
        tv.register(MoreBeerTableViewCell.self, forCellReuseIdentifier: "MoreBeerCell")
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        return tv
    }()
    
    //MARK: - Variables and Properties
    
    let dataSource = TableDataSourceModel()
    
    var viewModel: HomeViewModel
    
    init(_ user: AppUser) {
        self.viewModel = HomeViewModel(dataSource: self.dataSource, user: user)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard self.viewModel.dataSource?.selectedData.value == nil else { return }
        self.viewModel.getData(gif: .fill)
        self.configureDataSource()
    }
    
    //MARK: - View Config
    
    private func setUpViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(navBarBackgroundView)
        
        navBarBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBarBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBarBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navBarBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBarBackgroundView.heightAnchor.constraint(equalToConstant: 210).isActive = true

        view.addSubview(profileButton)
        
        profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(titleLabel)
        
        titleLabel.bottomAnchor.constraint(equalTo: navBarBackgroundView.bottomAnchor, constant: -30).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: navBarBackgroundView.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func configureDataSource() {
        self.tableView.delegate = self.dataSource
        self.tableView.dataSource = self.dataSource
        
        self.titleLabel.text = "Cheers\n\(viewModel.appUser.displayName ?? "")"
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.dataSource.selectedData.addAndNotify(observer: self) { [weak self] in
            
            guard let beerSelected = self?.dataSource.selectedData.value else { return }
            
            if beerSelected == Beer.empty {
                self?.viewModel.getData(gif: .colors)
            } else if let sender = self {
                NavigatorHelper.pushToDetail(from: sender, beer: beerSelected)
            }
        }
    }
    
    //MARK: - Button Actions
    
    @objc func logOutTapped() {
        self.viewModel.logOut(completion: {
            NavigatorHelper.pushToLogIn(from: self)
        })
    }
}
