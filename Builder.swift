//
//  Builder.swift
//  LazyContainer
//
//  Created by Takayuki Yamaguchi on 2023-01-03.
//

protocol AnyBuilder {}

public class Builder<T>: AnyBuilder {
    private var builder: () -> T
    private var cache: T? = nil
    private let lock = NSLock()
    
    public var dependency: T {
        get {
            lock.lock()
            defer {
                lock.unlock()
            }
            
            if let cache {
                return cache
            }
            let dependency = builder()
            self.cache = dependency
            return dependency
        }
    }
    
    public init(_ builder: @escaping () -> T) {
        self.builder = builder
    }
}
