//
//  AnimalView.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-12.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

struct AnimalView: View {
    @ObservedObject var viewModel: AnimalViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.getAnimals()
            } label: {
                Text("Get Animals")
            }

            Text(viewModel.animals.description)
            
            Divider()
            
            NavigationLink("Go to CatView") {
                CatView(viewModel: CatViewModel(container: viewModel.container))
            }
            NavigationLink("Go to DogView") {
                DogView(viewModel: DogViewModel(container: viewModel.container))
            }
        }
    }
}

struct AnimalView_Previews: PreviewProvider {
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
