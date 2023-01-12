//
//  DogView.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-11.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

struct DogView: View {
    @ObservedObject var viewModel: DogViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.getDogs()
            } label: {
                Text("Get cats")
            }

            Text(viewModel.dogs.description)
        }
    }
}

struct DogView_Previews: PreviewProvider {
    struct MockDogRepository: DogRepository {
        func getLatestDogs() async -> [Dog] {
            return [Dog(message: "Mock dog")]
        }
    }
    
    struct WrapperView: View {
        let container: LazyContainer = {
            let container = LazyContainer()
            container.register { _ in
                return MockDogRepository() as DogRepository
            }
            return container
        } ()
        
        var body: some View {
            DogView(viewModel: DogViewModel(container: container))
        }
    }
    
    static var previews: some View {
        WrapperView()
    }
}
