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

    func testListNil() throws {
        let list = viewModel.list.value
        let tasks = try AssertNotNilAndUnwrap(list)
        XCTAssertNil(tasks.taskIdList)
    }
    
    func testNetworkingState() {
        if let state = viewModel.networkingState.value {
            XCTAssertEqual(state, NetworkingState.default, state.id)
        }
    }
    
    func testListReturn() throws {
        
        viewModel.getList()
        
        let list = viewModel.list.value
        let tasks = try AssertNotNilAndUnwrap(list)
        let taksList = try AssertNotNilAndUnwrap(tasks.taskIdList)
        XCTAssert(taksList.count == 4)
    }
    
    func AssertNotNilAndUnwrap<T>(_ variable: T?, message: String = "Unexpected nil variable", file: StaticString = #file, line: UInt = #line) throws -> T {
        guard let variable = variable else {
            XCTFail(message, file: file, line: line)
            throw UnexpectedNilError()
        }
        return variable
    }

    struct UnexpectedNilError: Error {}
}
