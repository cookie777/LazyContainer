//
//  HomeViewModel.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-13.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import LazyContainer

final class HomeViewModel {
    let container: LazyContainer
    
    init(container: LazyContainer) {
        self.container = container
    }
}
