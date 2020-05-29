//
//  DataBaseError.swift
//  DBClient
//
//  Created by Serhii Butenko on 19/12/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

public enum DataBaseError: Error {

    case write(Error)
    case read(Error)
    case missingPrimaryKey
    case missingData
}
