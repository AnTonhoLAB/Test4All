//
//  DecodeTests.swift
//  Test4AllTests
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import XCTest

class DecodeTests: XCTestCase {

    var json: Data!
    
    override func setUp() {

        if let path = Bundle.main.path(forResource: "Task", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.json = data
            } catch {
                fatalError()
            }
        }
    }

    override func tearDown() {
       self.json = nil
    }
    
    func testDecode() {
        XCTAssertNoThrow(try Decode.decodeObject(type: Task.self, from: json))
    }
    
    func testDields() {
        XCTAssertNoThrow(try Decode.decodeObject(type: Task.self, from: json))  { task in
            XCTAssertNotNil(task.id)
            XCTAssertNotNil(task.urlLogo)
            XCTAssertNotNil(task.city)
            XCTAssertNotNil(task.neighboorhood)
        }
    }
    
    func testFailDecode() {
        XCTAssertThrowsError(try Decode.decodeObject(type: String.self, from: json))
    }

}

public func XCTAssertNoThrow<T> (_ expression: @autoclosure () throws -> T, _ message: String = "", file: StaticString = #file, line: UInt = #line, _ resultHandler: (T) -> Void) {
    
    func executeAndAssignResult (_ expression: @autoclosure () throws -> T, to: inout T?) rethrows {
        to = try expression()
    }
    
    var result: T?
    XCTAssertNoThrow(try executeAndAssignResult(expression(), to: &result), message, file: file, line: line)
    if let r = result {
        resultHandler(r)
    }
}
