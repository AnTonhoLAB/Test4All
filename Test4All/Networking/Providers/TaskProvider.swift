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
    
    func getList(completion: @escaping (Result<Int, NetworkingError>) -> Void) {
        
        guard let url =  URL(string: url + basePath + task) else {
            completion(.failure(.urlBuildingError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { result  in
            switch result {
            case .success(let response, let data):
                // Handle Data and Response
                break
            case .failure(let error):
                let err = NetworkingError(error: error)
                completion(.failure(err))
                break
            }
        }.resume()
    }
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
