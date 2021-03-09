//
//  ResultHandler.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import Foundation

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}
