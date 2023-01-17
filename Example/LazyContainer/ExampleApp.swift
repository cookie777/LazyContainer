//
//  ExampleApp.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-12.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

@main
struct SampleApp: App {
    private let container: LazyContainer
    
    init() {
        self.container = LazyContainer()
        
        /// Register dependencies.
        /// The order doesn't matter, but we must register all of them
        container.register { container in
            let repository: CatRepository = CatRepositoryImp(remoteDataSource: container.resolve(), localDataSource: container.resolve())
            return repository
        }
        container.register { container in
            let repository: DogRepository = DogRepositoryImp(remoteDataSource: container.resolve(), localDataSource: container.resolve())
            return repository
        }
        container.register { container in
            let dataSource: RemoteDataSource = RestAPIDataSource()
            return dataSource
        }
        container.register { container in
            let dataSource: LocalDataSource = LocalDBDataSource()
            return dataSource
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(container: container))
        }
    }
}
