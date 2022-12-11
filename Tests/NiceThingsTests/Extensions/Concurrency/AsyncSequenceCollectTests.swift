//
//  AsyncSequenceCollectTests.swift
//  
//
//  Created by Jesse Tipton on 12/10/22.
//

import XCTest
import NiceThings

final class AsyncSequenceCollectTests: XCTestCase {
    func testCollect() async {
        let stream = AsyncStream { continuation in
            continuation.yield(1)
            continuation.yield(2)
            continuation.yield(3)
            continuation.finish()
        }
        
        let output = await stream.collect()
        
        XCTAssertEqual(output, [1, 2, 3])
    }
    
    func testCollectOnThrowingSequence() async throws {
        let throwingStream = AsyncThrowingStream { continuation in
            continuation.yield(1)
            continuation.yield(2)
            continuation.yield(3)
            continuation.finish()
        }
        
        let output = try await throwingStream.collect()
        
        XCTAssertEqual(output, [1, 2, 3])
    }
}
