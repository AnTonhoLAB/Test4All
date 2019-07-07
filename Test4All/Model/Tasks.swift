//
//  Tasks.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

struct Tasks: Codable {

    var taskIdList: [String]?

    init(taskId:[String]) {
        self.taskIdList = taskId
    }

    public enum CodingKeys: String, CodingKey {
        case taskIdList = "lista"
    }
}
