//
//  DogViewModel.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-11.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

class DogViewModel: ObservableObject {
    
    @Published var dogs: [Dog] = []
    private let container: LazyContainer
    
    internal init(container: LazyContainer) {
        self.container = container
    }
    
    func getDogs() {
        let repository: DogRepository = container.resolve()
        Task {
            let dogs = await repository.getLatestDogs()
            await MainActor.run(body: {
                self.dogs = dogs
            })
        }
    }
}

