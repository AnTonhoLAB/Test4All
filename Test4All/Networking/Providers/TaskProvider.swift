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
    private let idToSend = "/%@"
    
    func getList(completion: @escaping (Result<Tasks, NetworkingError>) -> Void) {
        
        guard let url =  URL(string: url + basePath + task) else {
            completion(.failure(.urlBuildingError))
            return
        }
        
        let completionHandler: (Result<Tasks, Error>) -> Void = responseBuilder(completion: completion)
        URLSession.shared.dataTask(with: url, completion: completionHandler).resume()
    }
    
    func getTask(with id: String, completion: @escaping (Result<Task, NetworkingError>) -> Void) {
        let idEndPoint =  String(format: idToSend, id)
        guard let url =  URL(string: url + basePath + task + idEndPoint) else {
            completion(.failure(.urlBuildingError))
            return
        }
        
        let completionHandler: (Result<Task, Error>) -> Void = responseBuilder(completion: completion)
        URLSession.shared.dataTask(with: url, completion: completionHandler).resume()
    }
    
    
    func responseBuilder<T>(completion: @escaping (Result<T, NetworkingError>) -> Void  ) -> (Result<T, Error>) -> Void where T: Decodable {
        return  { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                let networkingError = NetworkingError(error: error)
                completion(.failure(networkingError))
            }
        }
    }
}
