//
//  BuilderTests.swift
//  LazyContainer_Tests
//
//  Created by Takayuki Yamaguchi on 2023-01-04.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import LazyContainer

final class BuilderTests: XCTestCase {

    func testBuilderNotCalled() {
        let flagManger = FlagManager()
        let _ = Builder {
            ServiceA(flagManger)
        }
        XCTAssertEqual(flagManger.initCountA, 0)
    }
    
    func testBuilderInit() {
        let flagManger = FlagManager()
        let builderServiceA = Builder {
            ServiceA(flagManger)
        }
        let _ = builderServiceA.dependency
        XCTAssertEqual(flagManger.initCountA, 1)
    }
    
    func testBuilderReuse() {
        let flagManger = FlagManager()
        let builderServiceA = Builder {
            ServiceA(flagManger)
        }
        let _ = builderServiceA.dependency
        let _ = builderServiceA.dependency
        XCTAssertEqual(flagManger.initCountA, 1)
    }
    
    func testBuilderOverride() {
        let flagManger = FlagManager()
        let _ = Builder {
            ServiceA(flagManger)
        }
        let builderServiceA2 = Builder {
            ServiceA(flagManger)
        }
        let _ = builderServiceA2.dependency
        XCTAssertEqual(flagManger.initCountA, 1)
    }
}

