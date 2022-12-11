//
//  AsyncSequence+Collect.swift
//  
//
//  Created by Jesse Tipton on 12/10/22.
//

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
extension AsyncSequence {
    public func collect() async rethrows -> [Element] {
        try await reduce(into: [Element]()) { $0.append($1) }
    }
}
