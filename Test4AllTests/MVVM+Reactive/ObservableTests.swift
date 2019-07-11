//
//  Bindable.swift
//  Test4AllTests
//
//  Created by George Gomes on 08/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import XCTest

class ObservableTests: XCTestCase {

    var observable: Observable<String>!
    
    override func setUp() {
        observable = Observable<String>("Teste")
    }

    override func tearDown() {
       observable = nil
    }

    func testExample() {
        XCTAssert(observable.value == "Teste")
        observable.value = "Teste2"
    }
}
