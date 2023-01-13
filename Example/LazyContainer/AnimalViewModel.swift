//
//  AnimalViewModel.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-12.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

class AnimalViewModel: ObservableObject {
    
    @Published var animals: [Animal] = []
    private let container: LazyContainer
    
    internal init(container: LazyContainer) {
        self.container = container
    }
    
    func getAnimals() {
        let catRepository: CatRepository = container.resolve()
        let dogRepository: DogRepository = container.resolve()
        Task {
            let cats = await catRepository.getLatestCats()
            let dogs = await dogRepository.getLatestDogs()
            await MainActor.run(body: {
                var animals: [Animal] = []
                animals.append(contentsOf: cats)
                animals.append(contentsOf: dogs)
                self.animals = animals
            })
        }
    }
}


