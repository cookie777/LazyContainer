//
//  HelperClasses.swift
//  LazyContainer_Tests
//
//  Created by Takayuki Yamaguchi on 2023-01-04.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

final class FlagManager {
    var initCountA = 0
    var initCountB = 0
    var initCountC = 0
    var initCountD = 0
}

protocol Service {}

final class ServiceA: Service {
    let flagManager: FlagManager?
    init(_ flagManager: FlagManager? = nil) {
        self.flagManager = flagManager
        self.flagManager?.initCountA += 1
        print("A")
    }
}

final class ServiceAMock: Service {}

final class ServiceB {
    let flagManager: FlagManager?
    let serviceA: ServiceA
    init(_ flagManager: FlagManager? = nil, serviceA: ServiceA) {
        self.flagManager = flagManager
        self.flagManager?.initCountB += 1
        self.serviceA = serviceA
        print("B")
    }
}

final class ServiceC {
    let flagManager: FlagManager?
    let serviceB: ServiceB
    init(_ flagManager: FlagManager? = nil, serviceB: ServiceB) {
        self.flagManager = flagManager
        self.flagManager?.initCountC += 1
        self.serviceB = serviceB
        print("C")
    }
}

final class ServiceD {
    let flagManager: FlagManager?
    let serviceA: ServiceA
    let serviceB: ServiceB
    let serviceC: ServiceC
    init(
        _ flagManager: FlagManager? = nil,
        serviceA: ServiceA,
        serviceB: ServiceB,
        serviceC: ServiceC
    ) {
        self.flagManager = flagManager
        self.flagManager?.initCountD += 1
        self.serviceA = serviceA
        self.serviceB = serviceB
        self.serviceC = serviceC
        print("D")
    }
}
