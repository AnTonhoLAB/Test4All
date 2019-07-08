//
//  ListProvider.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

protocol Credentiable {
    var url: String { get }
    var basePath: String { get }
    var task: String { get }
    var idToSend: String { get }
}

struct Credentials: Credentiable {
    var url = "http://dev.4all.com"
    var basePath = ":3003"
    var task = "/tarefa"
    var idToSend = "/%@"
}

final class TaskProvider: TaskProviderProtocol {
    
    private var credentials: Credentiable!
    
    init(_ credentials: Credentiable?) {
        if let credentials = credentials {
            self.credentials = credentials
        } else {
            self.credentials = Credentials()
        }
    }
    
    // Get list to show in list screen
    func getList(completion: @escaping (Result<Tasks, NetworkingError>) -> Void) {
        
        guard let url =  URL(string: credentials.url + credentials.basePath + credentials.task) else {
            completion(.failure(.urlBuildingError))
            return
        }
        
        // Call responseBuilder to avoid this code repetition in all functions:
//        let completionHandler: (Result<Task, Error>) -> Void =  { result in
//            switch result {
//            case .success(let task):
//                completion(.success(task))
//            case .failure(let error):
//                let networkingError = NetworkingError(error: error)
//                completion(.failure(networkingError))
//            }
//        }

        let completionHandler: (Result<Tasks, Error>) -> Void = responseBuilder(completion: completion)
        URLSession.shared.dataTask(with: url, completion: completionHandler).resume()
    }
    
    // Get a specific task from list in getList function
    func getTask(with id: String, completion: @escaping (Result<Task, NetworkingError>) -> Void) {
        let idEndPoint =  String(format: credentials.idToSend, id)
        guard let url =  URL(string: credentials.url + credentials.basePath + credentials.task + idEndPoint) else {
            completion(.failure(.urlBuildingError))
            return
        }
        
        let completionHandler: (Result<Task, Error>) -> Void = responseBuilder(completion: completion)
        URLSession.shared.dataTask(with: url, completion: completionHandler).resume()
    }
    
    func getImageData(withLink: String, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
        guard let url =  URL(string: withLink) else {
            completion(.failure(.urlBuildingError))
            return
        }
        
        let completionHandler: (Result<Data, Error>) -> Void = responseBuilder(completion: completion)
        URLSession.shared.dataTaskData(with: url, completion: completionHandler).resume()
    }
    
    // Generic return implementation to reuse in the above functions
    private func responseBuilder<T>(completion: @escaping (Result<T, NetworkingError>) -> Void  ) -> (Result<T, Error>) -> Void where T: Decodable {
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
