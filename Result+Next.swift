//
//  Result+Next.swift
//  DBClient
//
//  Created by Roman Kyrylenko on 30.05.2020.
//

import Foundation

extension Result {
    
    public var value: Success? {
        switch self {
        case .success(let result): return result
        case .failure: return nil
        }
    }
    
    public var error: Failure? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}

extension Result {
    
    @discardableResult
    public func map<U>(_ f: (Success) -> U) -> Result<U, Failure> {
        switch self {
        case .success(let t): return .success(f(t))
        case .failure(let error): return .failure(error)
        }
    }
    
    @discardableResult
    public func map<U>(_ f: () -> U) -> Result<U, Failure> {
        switch self {
        case .success: return .success(f())
        case .failure(let error): return .failure(error)
        }
    }
    
    @discardableResult
    public func next<U>(_ f: (Success) -> Result<U, Failure>) -> Result<U, Failure> {
        switch self {
        case .success(let t): return f(t)
        case .failure(let error): return .failure(error)
        }
    }
    
    @discardableResult
    public func next<U>(_ f: () -> Result<U, Failure>) -> Result<U, Failure> {
        switch self {
        case .success: return f()
        case .failure(let error): return .failure(error)
        }
    }
    
    @discardableResult
    public func onError(_ f: (Failure) -> Error) -> Result<Success, Error> {
        switch self {
        case .success(let value): return .success(value)
        case .failure(let error): return .failure(f(error))
        }
    }
    
    @discardableResult
    public func require() -> Success {
        switch self {
        case .success(let value): return value
        case .failure(let error): fatalError("Value is required: \(error)")
        }
    }
}
