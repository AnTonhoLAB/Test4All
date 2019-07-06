//
//  ListProvider.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

final class TaskProvider: TaskProviderProtocol {
    private let url = "http://dev.4all.com"
    private let basePath = ":3003"
    private let task = "/tarefa"
    
    func getList(completion: @escaping (Result<Tasks, NetworkingError>) -> Void) {
        
        guard let url =  URL(string: url + basePath + task) else {
            completion(.failure(.urlBuildingError))
            return
        }
        
        let completionHandler: (Result<Tasks, Error>) -> Void =  { result in
            switch result {
            case .success(let tasks):
                completion(.success(tasks))
            case .failure(let error):
                let networkingError = NetworkingError(error: error)
                completion(.failure(networkingError))
            }
        }
        
        URLSession.shared.dataTask(with: url, completion: completionHandler).resume()

    }
}
