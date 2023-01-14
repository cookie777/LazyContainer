//
//  HomeView.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-13.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

struct HomeView: View {
    let viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                NavigationLink( "Go to AnimalView") {
                    AnimalView(viewModel: AnimalViewModel(container: viewModel.container))
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    struct MockDogRepository: DogRepository {
        func getLatestDogs() async -> [Dog] {
            return [Dog(message: "Mock dog")]
        }
    }
    struct MockCatRepository: CatRepository {
        func getLatestCats() async -> [Cat] {
            return [Cat(message: "Mock cat")]
        }
    }
    
    struct WrapperView: View {
        let container: LazyContainer = {
            let container = LazyContainer()
            container.register { _ in
                return MockDogRepository() as DogRepository
            }
            container.register { _ in
                return MockCatRepository() as CatRepository
            }
            return container
        } ()
        
        var body: some View {
            AnimalView(viewModel: AnimalViewModel(container: container))
        }
    }
    
    static var previews: some View {
        WrapperView()
    }
}
