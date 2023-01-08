//
//  DogRepository.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

final class DogRepository {
    
    private var remoteDataSource: RemoteDataSource
    private var localDataSource: LocalDataSource
    
    init(remoteDataSource: RemoteDataSource, localDataSource: LocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getLatestCat() async -> [Dog] {
        let response: RemoteDataResponse<Dog> = await remoteDataSource.get(RemoteDataRequest())
        guard let dog = response.result else { return [] }
        
        _ = await localDataSource.update([dog])
        
        return [dog]
    }
}
