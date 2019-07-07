//
//  NetworkingError.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case wrongRequest
    case urlBuildingError
    
    init(error: Error){
        switch error {
       
        default:
            self = .wrongRequest
        }
    }
}
