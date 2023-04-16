//
//  MigrationType.swift
//  DBClient
//
//  Created by Roman Kyrylenko on 30.05.2020.
//

public enum MigrationType {
    
    // provide persistent store constructor with appropriate options
    case lightweight
    // in case of failure old model file will be removed
    case removeOnFailure
    // perform progressive migration with delegate
    case progressive(MigrationManagerDelegate?)
    
    public func isLightweight() -> Bool {
        switch self {
        case .lightweight:
            return true
            
        default:
            return false
        }
    }
}
