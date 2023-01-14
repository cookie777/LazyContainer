//
//  CatView.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-08.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

struct CatView: View {
    @ObservedObject var viewModel: CatViewModel
    
    init(viewModel: CatViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button {
                viewModel.getCats()
            } label: {
                Text("Get cats")
            }

            Text(viewModel.cats.description)
        }
    }
}

struct CatView_Previews: PreviewProvider {
    struct MockCatRepository: CatRepository {
        func getLatestCats() async -> [Cat] {
            return [Cat(message: "Mock cat")]
        }
    }
    
    struct WrapperView: View {
        let container: LazyContainer = {
            let container = LazyContainer()
            container.register { _ in
                return MockCatRepository() as CatRepository
            }
            return container
        } ()
        
        var body: some View {
            CatView(viewModel: CatViewModel(container: container))
        }
    }
    
    static var previews: some View {
        WrapperView()
    }
}
