//
//  SequenceSumTests.swift
//  
//
//  Created by Jesse Tipton on 5/6/22.
//

import Testing
@testable import NiceThings

struct SequenceSumTests {
    @Test
    func emptySequence() {
        #expect([].sum() == 0)
    }
    
    @Test
    func sequenceContainingOnlyZero() {
        #expect([0].sum() == 0)
    }
    
    @Test
    func sequenceContainingOnlyOne() {
        #expect([1].sum() == 1)
    }
    
    @Test
    func sequenceContainingManyNonZeroElements() {
        #expect([1, 2, 3, 4, 5, 6].sum() == 21)
    }
}
