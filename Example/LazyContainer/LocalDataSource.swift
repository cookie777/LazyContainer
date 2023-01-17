//
//  LocalDataSource.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

protocol LocalDataSource {
    func read<T>(_ request: LocalDataRequest) async -> [T]
    func update<T>(_ source: [T]) async -> Bool
}
