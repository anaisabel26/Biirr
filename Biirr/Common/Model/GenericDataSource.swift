//
//  GenericDataSource.swift
//  Biirr
//
//  Created by Ana Márquez on 06/03/2021.
//

import Foundation

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    var selectedData: DynamicValue<T?> = DynamicValue(nil)
    var moreDataAvailable: DynamicValue<Bool> = DynamicValue(false)
}
