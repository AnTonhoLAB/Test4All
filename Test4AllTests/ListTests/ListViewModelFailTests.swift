//
//  ListViewModelFailTests.swift
//  Test4AllTests
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import XCTest

class ListViewModelFailTests: XCTestCase {

    var viewModel: ListViewModel!
    
    override func setUp() {
        viewModel = ListViewModel(TaskProviderFailProvider())
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
        XCTAssertNil(list.taskIdList)
    }
    
    func testNetworkingStateSuccess() {
        viewModel.getList()
        let currentState = viewModel.networkingState.value
        XCTAssertEqual(currentState, NetworkingState.fail(NetworkingError.wrongRequest))
    }
    
    func testListReturn() {
        viewModel.getList()
        
        let list = viewModel.list.value
        XCTAssertNil(list.taskIdList)
    }
}
