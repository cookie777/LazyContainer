//
//  HomeView.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-13.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel

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

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: HomeViewModel(container:))
//    }
//}
