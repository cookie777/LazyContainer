//
//  RemoteDataSource.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

protocol RemoteDataSource {
    func get<T: Decodable>(_ request: RemoteDataRequest) async -> RemoteDataResponse<T>
}
