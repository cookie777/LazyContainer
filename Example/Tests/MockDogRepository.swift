//
//  MockDogRepository.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-14.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

struct MockDogRepository: DogRepository {
    func getLatestDogs() async -> [Dog] {
        return [Dog(message: "Mock dog")]
    }
}
