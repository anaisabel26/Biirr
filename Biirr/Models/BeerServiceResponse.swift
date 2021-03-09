//
//  BeerServiceResponse.swift
//  Biirr
//
//  Created by Ana Márquez on 06/03/2021.
//

import Foundation

struct BeerServiceResponse {
    var currentPage: Int
    var numberOfPages: Int
    var totalResults: Int
    var data: [Beer?]
    
    var dataAvailableForRequest: Bool {
        return currentPage < numberOfPages && data.count < totalResults
    }
    
    static var empty: BeerServiceResponse {
        return BeerServiceResponse(dict: ["currentPage": 0, "numberOfPages": 1, "totalResults": 0, "data": []])
    }
    
    init(dict: [String: Any]? = nil) {
        self.currentPage = dict?["currentPage"] as? Int ?? 0
        self.numberOfPages = dict?["numberOfPages"] as? Int ?? 0
        self.totalResults = dict?["totalResults"] as? Int ?? 0
        
        self.data = (dict?["data"] as? [[String: Any]] ?? []).compactMap({ (item) -> Beer? in
            return Beer(data: item)
        })
    }
}

