//
//  LazyContainer.swift
//  LazyContainer
//
//  Created by Takayuki Yamaguchi on 2023-01-04.
//

/// An DI container class to keep objects lazily by using `Builder`.
public final class LazyContainer {
    
    /// An internal registry to keep track of builders
    private var builders: [String : AnyBuilder] = [:]
    
    public init() {}
    
    /// Register a builder by closure to the container.
    /// The registered-key will be it's object type.
    /// - Parameter builder: A  closure which returns an object. The internal object is not initialized until it's resolved. An unowned self-lazy-container is passed as a parameter in the closure so that you can call other dependencies by resolving them.
    public func register<T>(_ builder: @escaping (_ container: LazyContainer) -> T) {
        let key = "\(T.self)"
        // Register. Pass weak self-container for accessing other dependencies. "Weak" is for avoiding from ARC retain-cycle.
        builders[key] = Builder({ [weak self] in
            guard let self = self else { fatalError("Resolve was tried to called without LazyContainer.") }
            return builder(self)
        })
    }
    
    /// Register a builder to the container.
    /// The registered-key will be it's object type.
    /// - Parameter builder: `Builder` class. The internal object is not initialized until it's resolved.
    public func register<T>(_ builder: Builder<T>) {
        let key = "\(T.self)"
        builders[key] = builder
    }
    
    /// Resolve the object from the builder in the container
    /// - Returns: The object registered. **If no builder was found, it will throw a fatalError**
    public func resolve<T>() -> T {
        let key = "\(T.self)"
        guard let builder = builders[key] as? Builder<T> else {
            fatalError("No builder was found with key \(T.self)")
        }
        return builder.dependency
    }
    
    /// Resolve the object from the builder in the container
    /// - Returns: The object registered. Return `nil` if no builder was found.
    public func resolveOptional<T>() -> T? {
        let key = "\(T.self)"
        guard let builder = builders[key] as? Builder<T> else {
            return nil
        }
        return builder.dependency
    }
}
