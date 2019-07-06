//
//  URLSesion.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

extension URLSession {
    func dataTask<T>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask where T: Decodable {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                let myNewObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(myNewObject))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
