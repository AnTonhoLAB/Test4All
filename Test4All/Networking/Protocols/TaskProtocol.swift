//
//  ListProtocol.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

protocol TaskProviderProtocol {
    func getList(completion: @escaping(Result<Tasks,NetworkingError>)->Void)
    func getTask(with id: String, completion: @escaping (Result<Task, NetworkingError>) -> Void)
    func getImageData(withLink: String, completion: @escaping (Result<Data, NetworkingError>) -> Void)
}
