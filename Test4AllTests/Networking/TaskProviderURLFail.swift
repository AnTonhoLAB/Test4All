//
//  TaskProviderURLFail.swift
//  Test4AllTests
//
//  Created by George Gomes on 08/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import XCTest
import Mockingjay

class CredentialsFake: Credentiable {
    var url: String = "$`+}{ã"
    var basePath: String = "...."
    var task: String = ".."
    var idToSend: String = "////"
}

class TaskProviderURLFail: XCTestCase {

    var taskProvider: TaskProvider!
    
    override func setUp() {
        let credentials = CredentialsFake()
        self.taskProvider = TaskProvider(credentials)
        stub(http(.get, uri: "http://dev.4all.com:3003/tarefa"), failure(NetworkingError.urlBuildingError as NSError))
        stub(http(.get, uri: "http://dev.4all.com:3003/tarefa/{id}"), failure(NetworkingError.urlBuildingError as NSError))
    }

    override func tearDown() {
       taskProvider = nil
    }
    func testTasksReturn() {
        let expectation = self.expectation(description: "calls the callback with a resource object")
        
        taskProvider.getList(){(result) in
            switch result {
            case .success(let res):
                XCTAssertNotNil(res)
            case .failure(let err):
                XCTAssertEqual(err, NetworkingError.urlBuildingError)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.3, handler: .none)
        removeAllStubs()
    }
    
    func testTasksReturnItem() {
        let expectation = self.expectation(description: "calls the callback with a resource object")
        
        taskProvider.getList() {(result) in
            switch result {
            case .success(let res):
                XCTAssertNotNil(res.taskIdList)
            case .failure(let err):
                XCTAssertEqual(err, NetworkingError.urlBuildingError)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 0.3, handler: .none)
        removeAllStubs()
    }
    
    func testTaskReturn() {
        let expectation = self.expectation(description: "calls the callback with a resource object")
        
        taskProvider.getTask(with: "1") {(result) in
            switch result {
            case .success(let res):
                XCTAssertNotNil(res)
            case .failure(let err):
                XCTAssertEqual(err, NetworkingError.urlBuildingError)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.3, handler: .none)
        removeAllStubs()
    }
}
