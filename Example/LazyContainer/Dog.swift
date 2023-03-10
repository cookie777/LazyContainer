//
//  Dog.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

struct Dog {
    var message: String
}

extension Dog: Animal {}
extension Dog: Decodable {}
extension Dog: CustomStringConvertible {
    var description: String {
        return message
    }
}
