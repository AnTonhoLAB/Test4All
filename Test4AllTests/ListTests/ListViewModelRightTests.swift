//
//  ListViewModelTests.swift
//  Test4AllTests
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import XCTest

class ListViewModelTests: XCTestCase {

    var viewModel: ListViewModel!
    
    override func setUp() {
       viewModel = ListViewModel(TaskProviderRightProvider())
    }

    override func tearDown() {
        viewModel = nil
    }

    func testNetworkingState() {
        let currentState = viewModel.networkingState.value
        XCTAssertEqual(currentState, NetworkingState.default)
    }
    
    func testListNil() {
        let list = viewModel.list.value
        XCTAssertNil(list.taskIdList)
    }
    
    
    func testListNotNil() {
        viewModel.getList()
        
        let list = viewModel.list.value
        XCTAssertNotNil(list.taskIdList)
    }
    
    func testNetworkingStateSuccess() {
        viewModel.getList()
        let currentState = viewModel.networkingState.value
        XCTAssertEqual(currentState, NetworkingState.success)
    }
    
    func testListReturn() {
        viewModel.getList()
        
        let list = viewModel.list.value
        
        guard let taskList = list.taskIdList else { XCTFail("Error"); return }
        
        XCTAssert(taskList.count == 4)
    }
    
}
