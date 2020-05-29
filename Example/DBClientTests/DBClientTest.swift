//
//  DBClientTest.swift
//  DBClientTests
//
//  Created by Roman Kyrylenko on 2/8/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import XCTest
import DBClient
@testable import Example

class DBClientTest: XCTestCase {
    
    var dbClient: DBClient! { return nil }
    
    override func setUp() {
        super.setUp()
        
        cleanUpDatabase()
    }
    
    override func tearDown() {
        cleanUpDatabase()
        
        super.tearDown()
    }
    
    // removes all objects from the database
    func cleanUpDatabase() {
        guard dbClient != nil else { return }
        let expectationDeletion = expectation(description: "Deletion")
        var isDeleted = false
        
        dbClient.findAll { (result: Result<[User], DataBaseError>) in
            guard let objects = result.value else {
                expectationDeletion.fulfill()
                return
            }
            self.dbClient.delete(objects) { _ in
                isDeleted = true
                expectationDeletion.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssert(isDeleted)
        }
    }
}

extension Result {
    
    var value: Success? {
        switch self {
        case .success(let result): return result
        case .failure: return nil
        }
    }
    
    @discardableResult
    func require() -> Success {
        switch self {
        case .success(let value): return value
        case .failure(let error): fatalError("Value is required: \(error)")
        }
    }
}
