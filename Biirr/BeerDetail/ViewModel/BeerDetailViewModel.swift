//
//  BeerDetailViewModel.swift
//  Biirr
//
//  Created by Ana Márquez on 07/03/2021.
//

import Foundation

class BeerDetailViewModel {
    
    var beer: DynamicValue<Beer>
    
    init(_ beer: Beer) {
        self.beer = DynamicValue(beer)
    }
}
