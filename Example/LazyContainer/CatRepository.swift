//
//  CatRepository.swift
//  LazyContainer_Example
//
//  Created by Takayuki Yamaguchi on 2023-01-07.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

protocol CatRepository {
    func getLatestCats() async -> [Cat]
}

final class CatRepositoryImp: CatRepository {
    
    private var remoteDataSource: RemoteDataSource
    private var localDataSource: LocalDataSource
    
    init(remoteDataSource: RemoteDataSource, localDataSource: LocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        print("Cat Repo is init")
    }
    
    func getLatestCats() async -> [Cat] {
        let response: RemoteDataResponse<Cat> = await remoteDataSource.get(RemoteDataRequest())
        guard let cat = response.result else { return [] }
        
        _ = await localDataSource.update([cat])
        
        return [cat]
    }
}
