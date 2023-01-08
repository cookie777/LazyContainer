//
//  RemoteDataResponse.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

struct RemoteDataResponse<T> {
    var result: T?
    var error: Error?
    var statusCode: Int
}
