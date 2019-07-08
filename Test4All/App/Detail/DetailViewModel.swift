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
    
    let title = ""
    let networkingState: Observable<NetworkingState> = Observable(.default)
    let task = Observable<Task>(Task())
    
    init(_ provider: TaskProviderProtocol, _ id: String ) {
        self.id = id
        self.provider = provider
    }
    
    func getTask() {
        networkingState.value = .loading
        provider.getTask(with: id) { result in
            switch result {
            case .success(let task):
                self.networkingState.value = .success
                self.task.value = task
            case .failure(let err):
                self.networkingState.value = .fail(err)
            }
        }
    }
}
