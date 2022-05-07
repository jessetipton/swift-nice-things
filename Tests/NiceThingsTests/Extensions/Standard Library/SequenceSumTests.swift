//
//  SequenceSumTests.swift
//  
//
//  Created by Jesse Tipton on 5/6/22.
//

import XCTest
@testable import NiceThings

class SequenceSumTests: XCTestCase {
    func testEmptySequence() {
        XCTAssertEqual([].sum(), 0)
    }
    
    func testSequenceContainingOnlyZero() {
        XCTAssertEqual([0].sum(), 0)
    }
    
    func testSequenceContainingOnlyOne() {
        XCTAssertEqual([1].sum(), 1)
    }
    
    func testSequenceContainingManyNonZeroElements() {
        XCTAssertEqual([1, 2, 3, 4, 5, 6].sum(), 21)
    }
}
