//
//  AsyncSequenceCollectTests.swift
//  
//
//  Created by Jesse Tipton on 12/10/22.
//

import Testing
@testable import NiceThings

struct AsyncSequenceTests {
    @Test
    func collect() async {
        let stream = AsyncStream { continuation in
            continuation.yield(1)
            continuation.yield(2)
            continuation.yield(3)
            continuation.finish()
        }
        
        let output = await stream.collect()
        
        #expect(output == [1, 2, 3])
    }
    
    @Test
    func collectOnThrowingSequence() async throws {
        let throwingStream = AsyncThrowingStream { continuation in
            continuation.yield(1)
            continuation.yield(2)
            continuation.yield(3)
            continuation.finish()
        }
        
        let output = try await throwingStream.collect()
        
        #expect(output == [1, 2, 3])
    }
}
