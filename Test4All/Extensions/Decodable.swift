//
//  Decodable.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

extension Decodable {
    static func decodeObject<T>(type: T.Type, from data: Data) where T: Decodable  {
        let decoder = JSONDecoder()
        do {
            let userDictionary = try decoder.decode(T.self, from: data)
            print(userDictionary)
        } catch {
            print(error)
        }
    }
}
