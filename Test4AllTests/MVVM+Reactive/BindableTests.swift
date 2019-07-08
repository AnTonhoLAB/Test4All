//
//  BindableTests.swift
//  Test4AllTests
//
//  Created by George Gomes on 08/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import XCTest

class BindableTests: XCTestCase {

    var vcBindable: UpdatableViewController!
    
    override func setUp() {
        vcBindable = ListViewController()
    }

    override func tearDown() {
        vcBindable = nil
    }

    func testExample() {
        XCTAssert(vcBindable.observingValue() == .default)
        vcBindable.updateValue(with: .loading)
        XCTAssert(vcBindable.observingValue() == .loading)
        vcBindable.updateValue(with: .success)
        XCTAssert(vcBindable.observingValue() == .success)
        vcBindable.updateValue(with: .fail(NetworkingError.urlBuildingError))
        XCTAssert(vcBindable.observingValue() == .fail(NetworkingError.urlBuildingError))
        vcBindable.updateValue(with: .default)
        XCTAssert(vcBindable.observingValue() == .default)
        
        
    }
    
    func testBindValue() {
        XCTAssertExpectFatalError(expectedMessage: "Type do not exist") {
            _ = self.vcBindable.getBinderValue()
        }
        
        let networkingState: Observable<NetworkingState> = Observable(.default)
        vcBindable.bind(with: networkingState)
        XCTAssertEqual(vcBindable.getBinderValue(), NetworkingState.default)
    }
}

extension XCTestCase {
    func XCTAssertExpectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        
        // arrange
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil
        
        // override fatalError. This will pause forever when fatalError is called.
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            unreachable()
        }
        
        // act, perform on separate thead because a call to fatalError pauses forever
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.1) { _ in
            // assert
            XCTAssertEqual(assertionMessage, expectedMessage)
            
            // clean up
            FatalErrorUtil.restoreFatalError()
        }
    }
}

// overrides Swift global `fatalError`
public func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
//    unreachable()
}

/// This is a `noreturn` function that pauses forever
public func unreachable() -> Never {
    repeat {
        RunLoop.current.run()
    } while (true)
}

/// Utility functions that can replace and restore the `fatalError` global function.
public struct FatalErrorUtil {
    
    // Called by the custom implementation of `fatalError`.
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    // backup of the original Swift `fatalError`
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    /// Replace the `fatalError` global function with something else.
    public static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    
    /// Restore the `fatalError` global function back to the original Swift implementation
    public static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
