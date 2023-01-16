//
//  CatViewModel.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-11.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

final class CatViewModel: ObservableObject {
    
    @Published var cats: [Cat] = []
    private let container: LazyContainer
    
    init(container: LazyContainer) {
        self.container = container
    }
    
    func getCats() {
        let catRepository: CatRepository = container.resolve()
        Task {
            let cats = await catRepository.getLatestCats()
            await MainActor.run(body: {
                self.cats = cats
            })
        }
    }
}
