//
//  Task+Sleep.swift
//  
//
//  Created by Jesse Tipton on 5/6/22.
//

import Foundation

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
extension Task where Success == Never, Failure == Never {
    /// Suspends the current task for at least the given duration in seconds.
    public static func sleep(seconds: UInt64) async throws {
        try await sleep(nanoseconds: seconds * NSEC_PER_SEC)
    }
}
