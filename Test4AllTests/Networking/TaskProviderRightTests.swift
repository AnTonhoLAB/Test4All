//
//  TaskProviderTests.swift
//  Test4AllTests
//
//  Created by George Gomes on 08/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import XCTest
import Mockingjay

class TaskProviderRightTests: XCTestCase {

    var taskProvider: TaskProvider!
    
    override func setUp() {
        let tasksJson = "{\"lista\":[\"1111\",\"666\",\"333\",\"primeiro\"]}"
        let tasksData = Data(tasksJson.utf8)
        let taskJson = "{\"id\":\"94\",\"cidade\":\"Porto Alegre\",\"bairro\":\"Moinhos de Vento\",\"urlFoto\":\"http://dev.4all.com:3003/foto_01.jpg\",\"urlLogo\":\"http://dev.4all.com:3003/logo_01.png\",\"titulo\":\"Lorem Ipsum\",\"telefone\":\"5122333311\",\"texto\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus finibus consequat nulla, a laoreet ipsum blandit ac. Donec vitae convallis nisi. Mauris molestie id lorem quis dignissim. Cum sociis natoque penatibus et magnis dis parturient montes.\",\"endereco\":\"Avenida Carlos Gomes, 532\",\"latitude\":-30.0306551,\"longitude\":-51.1846846,\"comentarios\":[{\"urlFoto\":\"http://dev.4all.com:3003/usuario1.jpeg\",\"nome\":\"Lorem Ipsum\",\"nota\":2,\"titulo\":\"Consequat Nulla\",\"comentario\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus finibus consequat nulla, a laoreet ipsum blandit ac. Donec vitae convallis nisi.\"},{\"urlFoto\":\"http://dev.4all.com:3003/usuario2.jpeg\",\"nome\":\"Mauris Molestie\",\"nota\":5,\"titulo\":\"finibus consequat\",\"comentario\":\"Aliquam eu lacinia justo. Aliquam a arcu nibh. Integer tincidunt nisi ac nibh posuere, in finibus turpis eleifend. Duis augue mauris, scelerisque non sem a, dictum volutpat urna.\"}]}"
        let taskData = Data(taskJson.utf8)
        self.taskProvider = TaskProvider(nil)
        stub(http(.get, uri: "http://dev.4all.com:3003/tarefa"), http(200, headers: ["Content-Type":"application/json"], download: .content(tasksData)))
        stub(http(.get, uri: "http://dev.4all.com:3003/tarefa/{id}"), http(200, headers: ["Content-Type":"application/json"], download: .content(taskData)))
    }

    override func tearDown() {
        self.taskProvider = nil
    }

    func testTasksReturn() {
        let expectation = self.expectation(description: "calls the callback with a resource object")

        taskProvider.getList(){(result) in
            switch result {
            case .success(let res):
                XCTAssertNotNil(res)
            case .failure(let err):
                XCTFail(err.localizedDescription)
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
                XCTAssert(res.taskIdList?[0] == "1111")
            case .failure(let err):
                XCTFail(err.localizedDescription)
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
                XCTFail(err.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.3, handler: .none)
        removeAllStubs()
    }
    
    func testTaskReturnItem() {
        let expectation = self.expectation(description: "calls the callback with a resource object")
        
        taskProvider.getTask(with: "2") {(result) in
            switch result {
            case .success(let res):
                XCTAssertNotNil(res.id)
                XCTAssert(res.id == "94")
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 0.3, handler: .none)
        removeAllStubs()
    }
}
