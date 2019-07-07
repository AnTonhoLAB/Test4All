//
//  ListViewModel.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

final class ListViewModel {
    
    let title = "Lista de ids"
    let networkingState: Observable<NetworkingState> = Observable(.default)
    let list: Observable<Tasks> = Observable(Tasks())
    
    private var provider: TaskProviderProtocol!
    
    init(_ provider: TaskProviderProtocol ) {
        self.provider = provider
    }
    
    func getList() {
        networkingState.value = .loading
        provider.getList { result in
            switch result {
            case .success(let list):
                self.list.value = list
                self.networkingState.value = .success
            case .failure(let error):
                self.networkingState.value = .fail(error)
            }
        }
    }
}

