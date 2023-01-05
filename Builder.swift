//
//  Builder.swift
//  LazyContainer
//
//  Created by Takayuki Yamaguchi on 2023-01-03.
//

import Foundation

/// This protocol is to manage multiple types of generics<T> without using `any`
protocol AnyBuilder {}

/// A object builder to initialize instance lazily.
public final class Builder<T>: AnyBuilder {
    /// An internal closure which constructs and returns the object. The object is not initialized until it's first called.
    private var builder: () -> T
    private var cache: T? = nil
    private let lock = NSLock()
    
    /// Access the instance.
    /// If it's the first time, it will try to construct the object from the builder, and store the result to the cache. After that, it will use the cache.
    /// While accessing, it will make a lock. This is to prevent a data race. **Please consider the dependency-graph otherwise it may cause a dead lock**
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
