//
//  TaskProviderRightProvider.swift
//  Test4AllTests
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

final class TaskProviderRightProvider: TaskProviderProtocol {
    func getList(completion: @escaping (Result<Tasks, NetworkingError>) -> Void) {
        completion(.success(Tasks(taskId: ["1","b","c33","ultimo"])))
    }
    
    func getTask(with id: String, completion: @escaping (Result<Task, NetworkingError>) -> Void) {
        completion(.success(Task(id: "1", city: "Porto Alegre", neighboorhood: "Moinhos de Vento", urlPhoto: "http://dev.4all.com:3003/foto_01.jpg", urlLogo: "urlLogo", title: "Lorem Ipsum", telephoneNumber: "5122333311", descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus finibus consequat nulla, a laoreet ipsum blandit ac. Donec vitae convallis nisi. Mauris molestie id lorem quis dignissim. Cum sociis natoque penatibus et magnis dis parturient montes.", address: "Avenida Carlos Gomes, 532", latitude: -30.0306551, longitude: -51.1846846)))
    }
    
    func getImageData(withLink: String, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
        
    }
}
