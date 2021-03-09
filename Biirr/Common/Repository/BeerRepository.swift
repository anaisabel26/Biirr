//
//  BeerRepository.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import Foundation

class BeerRepository {
    
    private let key: String = "13d7fdca22cbc95434f3f65d7be4a5a9"
    private let apiString: String = "http://api.brewerydb.com/v2/beers/?"
    
    func getBeers(_ currentPage: Int = 1, handler: @escaping (Result<BeerServiceResponse, String>) -> Void) {
        
        let urlString = apiString + "p=\(currentPage)" + "&key=\(key)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                        
                        let serviceRespose = BeerServiceResponse(dict: json)
                        handler(.success(serviceRespose))
                    }

                } catch (let error) {
                    handler(.failure(error.localizedDescription))
                }
                
            } else if let err = err {
                handler(.failure(err.localizedDescription))
            }
            
        }.resume()
    }
}
