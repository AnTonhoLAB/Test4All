//
//  DetailViewModel.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    private var id: String!
    private var provider: TaskProviderProtocol!
    
    let task = Observable<Task>(Task())
    
    init(_ provider: TaskProviderProtocol, _ id: String ) {
        self.id = id
        self.provider = provider
    }
    
    
}
