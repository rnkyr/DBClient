//
//  DBClientCoreDataTest.swift
//  DBClientTests
//
//  Created by Roman Kyrylenko on 10/23/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import XCTest
import DBClient
import DBClientCoreData

class DBClientCoreDataTest: DBClientTest {
    
    private let client = CoreDataDBClient(forModel: "Users")
    override var dbClient: DBClient! {
        return client
    }
}
