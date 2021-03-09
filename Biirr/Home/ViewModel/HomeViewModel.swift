//
//  HomeViewModel.swift
//  Biirr
//
//  Created by Ana Márquez on 06/03/2021.
//

import Foundation

class HomeViewModel {
    
    weak var dataSource: GenericDataSource<Beer>?
    
    private var authRepository = AuthRepository()
    
    var appUser: AppUser
    
    var error: String? = nil {
        didSet {
            guard let err = self.error else { return }
            ErrorView.shared.showError(err)
        }
    }
    
    lazy var beerRepository: BeerRepository = { [unowned self] in
        return BeerRepository()
    }()
    
    private var beerServiceResponse: BeerServiceResponse {
        didSet {
            self.updateDataSourceValues()
        }
    }
    
    init(dataSource: GenericDataSource<Beer>?, user: AppUser) {
        self.beerServiceResponse = BeerServiceResponse.empty
        self.dataSource = dataSource
        self.appUser = user
    }
    
    func getData(gif: GiftOptions = .fill) {
        LoadingView.shared.showOverlay(gif: gif)
        
        beerRepository.getBeers(self.beerServiceResponse.currentPage + 1) { (result) in
            switch result {
            case .success(let service):
                LoadingView.shared.hideOverlayView {
                    self.beerServiceResponse = service
                }
                
            case .failure(let err):
                LoadingView.shared.hideOverlayView {
                    self.error = err
                }
            }
        }
    }
    
    func logOut(completion: @escaping (() -> Void)) {
        authRepository.logOut { (result) in
            switch result {
            case .success(_):
                completion()
            case .failure(let err):
                self.error = err
            }
        }
    }
    
    private func updateDataSourceValues() {
        self.dataSource?.moreDataAvailable.value = beerServiceResponse.dataAvailableForRequest
        
        var data: [Beer] = self.dataSource?.data.value ?? []
        data.append(contentsOf: beerServiceResponse.data.compactMap({ $0 }))
        
        self.dataSource?.data.value = data
    }
}
