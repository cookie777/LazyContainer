//
//  LocalDBDataSource.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

final class LocalDBDataSource: LocalDataSource {
    init () {
        print("\(Self.self) init")
    }
    deinit {
        print("\(Self.self) de-init")
    }
    
    func read<T>(_ request: LocalDataRequest) async -> [T] {
        switch T.self {
        case is Cat.Type:
            return [Cat(message: "Cat")] as! [T]
        case is Dog.Type:
            return [Dog(message: "Dog")] as! [T]
        default:
            return []
        }
    }
    
    func update<T>(_ source: [T]) async -> Bool {
        return true
    }
}
