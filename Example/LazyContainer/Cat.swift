//
//  Cat.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

struct Cat {
    var message: String
}
extension Cat: Animal {}
extension Cat: Decodable {}

extension Cat: CustomStringConvertible {
    var description: String {
        return message
    }
}
