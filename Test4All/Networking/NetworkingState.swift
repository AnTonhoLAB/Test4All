//
//  NetworkingState.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

enum NetworkingState: Equatable {
    case loading
    case success
    case fail(Error)
    case `default`
    
    static func == (lhs: NetworkingState, rhs: NetworkingState) -> Bool {
        return lhs == rhs
    }
}
