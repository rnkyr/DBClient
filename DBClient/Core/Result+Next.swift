//
//  Result+Next.swift
//  DBClient
//
//  Created by Roman Kyrylenko on 30.05.2020.
//

import Foundation

extension Result {
    
    @discardableResult
    func next<U>(_ f: (Success) -> Result<U, Failure>) -> Result<U, Failure> {
        switch self {
        case .success(let t): return f(t)
        case .failure(let error): return .failure(error)
        }
    }
}
