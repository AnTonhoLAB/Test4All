//
//  DetailViewModelRightTests.swift
//  Test4AllTests
//
//  Created by George Gomes on 08/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import XCTest

class DetailViewModelRightTests: XCTestCase {

    var viewModel: DetailViewModel!
    
    override func setUp() {
        viewModel = DetailViewModel(TaskProviderRightProvider(), "1")
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testNetworkingState() {
        let currentState = viewModel.networkingState.value
        XCTAssertEqual(currentState, NetworkingState.default)
    }
    
    func testListNil() {
        XCTAssertNil(viewModel.task.value.id)
    }
    
    
    func testListNotNil() {
        viewModel.getTask()
        XCTAssertNotNil(viewModel.task.value.id)
    }
    
    func testNetworkingStateSuccess() {
        viewModel.getTask()
        let currentState = viewModel.networkingState.value
        XCTAssertEqual(currentState, NetworkingState.success)
    }
//
//    func testListReturn() {
//        viewModel.getList()
//
//        let list = viewModel.list.value
//
//        guard let taskList = list.taskIdList else { XCTFail("Error"); return }
//
//        XCTAssert(taskList.count == 4)
//    }
    

}
