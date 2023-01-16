//
//  RestAPIDataSource.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

final class RestAPIDataSource: RemoteDataSource {
    init () {
        print("\(Self.self) init")
    }
    deinit {
        print("\(Self.self) de-init")
    }
    func get<T>(_ request: RemoteDataRequest) async -> RemoteDataResponse<T> where T : Decodable {
        switch T.self {
        case is Cat.Type:
            return .init(result: Cat(message: "Cat") as? T, error: nil, statusCode: 200)
        case is Dog.Type:
            return .init(result: Dog(message: "Dog") as? T, error: nil, statusCode: 200)
        default:
            return .init(statusCode: 400)
        }
    }
}
