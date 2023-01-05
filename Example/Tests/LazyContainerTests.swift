//
//  LazyContainerTests.swift
//  LazyContainer_Tests
//
//  Created by Takayuki Yamaguchi on 2023-01-04.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import LazyContainer

final class LazyContainerTests: XCTestCase {
    private var lazyContainer: LazyContainer!
    
    override func setUp() {
        lazyContainer = LazyContainer()
    }
    
    override func tearDown() {
        lazyContainer = nil
    }
    
    func testRegisterNotCalled() {
        let flagManager = FlagManager()
        lazyContainer.register { _ in
            ServiceA(flagManager)
        }
        XCTAssertEqual(flagManager.initCountA, 0)
    }
    
    func testResolveSuccess() {
        let flagManager = FlagManager()
        lazyContainer.register { _ in
            ServiceA(flagManager)
        }
        let serviceA: ServiceA = lazyContainer.resolve()
        XCTAssertEqual(flagManager.initCountA, 1)
        XCTAssertTrue((serviceA as Any) is ServiceA)
    }
    
    func testResolveReuse() {
        let flagManager = FlagManager()
        lazyContainer.register { _ in
            ServiceA(flagManager)
        }
        let _: ServiceA = lazyContainer.resolve()
        let _: ServiceA = lazyContainer.resolve()
        XCTAssertEqual(flagManager.initCountA, 1)
    }
    
    func testResolveOptionalSuccess() {
        let flagManager = FlagManager()
        lazyContainer.register { _ in
            ServiceA(flagManager)
        }
        let serviceA: ServiceA? = lazyContainer.resolveOptional()
        XCTAssertEqual(flagManager.initCountA, 1)
        XCTAssertTrue((serviceA as Any) is ServiceA)
    }
    
    func testResolveOptionalNil() {
        let serviceA: ServiceA? = lazyContainer.resolveOptional()
        XCTAssertNil(serviceA)
    }
    
    func testRegisterOverride() {
        lazyContainer.register { _ in
            let service: Service = ServiceA()
            return service
        }
        lazyContainer.register { _ in
            let service: Service = ServiceAMock()
            return service
        }
        let service: Service = lazyContainer.resolve()
        XCTAssert(service is ServiceAMock)
    }
    
    /// C -> B -> A
    func testDependenciesLine() {
        let flagManager = FlagManager()
        lazyContainer.register { container in
            ServiceC(flagManager, serviceB: container.resolve())
        }
        lazyContainer.register { container in
            ServiceB(flagManager, serviceA: container.resolve())
        }
        lazyContainer.register { container in
            ServiceA(flagManager)
        }
        let serviceC: ServiceC = lazyContainer.resolve()
        XCTAssertTrue((serviceC as Any) is ServiceC)
        XCTAssertEqual(flagManager.initCountA, 1)
        XCTAssertEqual(flagManager.initCountB, 1)
        XCTAssertEqual(flagManager.initCountC, 1)
    }
    
    /// D --> C---↓
    ///  ---------> B----↓
    ///  -------------- -> A
    func testDependenciesGraph() {
        let flagManager = FlagManager()
        lazyContainer.register { container in
            ServiceD(
                flagManager,
                serviceA: container.resolve(),
                serviceB: container.resolve(),
                serviceC: container.resolve()
            )
        }
        lazyContainer.register { container in
            ServiceC(flagManager, serviceB: container.resolve())
        }
        lazyContainer.register { container in
            ServiceB(flagManager, serviceA: container.resolve())
        }
        lazyContainer.register { container in
            ServiceA(flagManager)
        }
        let serviceD: ServiceD = lazyContainer.resolve()
        XCTAssertTrue((serviceD as Any) is ServiceD)
        XCTAssertEqual(flagManager.initCountA, 1)
        XCTAssertEqual(flagManager.initCountB, 1)
        XCTAssertEqual(flagManager.initCountC, 1)
        XCTAssertEqual(flagManager.initCountD, 1)
    }
}
