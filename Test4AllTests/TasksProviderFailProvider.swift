//
//  TasksProviderFailProvider.swift
//  Test4AllTests
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

final class TaskProviderFailProvider: TaskProviderProtocol {
    func getList(completion: @escaping (Result<Tasks, NetworkingError>) -> Void) {
        completion(.failure(NetworkingError.wrongRequest))
    }
    
    func getTask(with id: String, completion: @escaping (Result<Task, NetworkingError>) -> Void) {
        completion(.failure(NetworkingError.wrongRequest))
    }
    
    func getImageData(withLink: String, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
         completion(.failure(NetworkingError.wrongRequest))
    }
}
