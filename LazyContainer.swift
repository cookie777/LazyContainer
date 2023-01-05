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
    
    /// Register a builder to the container.
    /// The registered-key will be it's object type.
    /// - Parameter builder: a closure which returns an object. The object is not initialized until it's resolved.
    public func register<T>(_ builder: @escaping (_ container: LazyContainer) -> T) {
        let key = "\(T.self)"
        // Register. Pass self-container for accessing other dependencies
        builders[key] = Builder({ [weak self] in
            guard let self = self else { fatalError("Resolve was tried to called without LazyContainer.") }
            return builder(self)
        })
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
