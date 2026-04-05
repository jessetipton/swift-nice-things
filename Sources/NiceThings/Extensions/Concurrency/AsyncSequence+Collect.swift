//
//  AsyncSequence+Collect.swift
//  
//
//  Created by Jesse Tipton on 12/10/22.
//

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
extension AsyncSequence {
    /// Collects all elements from the async sequence into an array.
    ///
    /// Use this method when you need to gather every element produced by an async sequence
    /// into a single array.
    ///
    /// ```swift
    /// let numbers = [1, 2, 3].async
    /// let collected = await numbers.collect() // [1, 2, 3]
    /// ```
    ///
    /// - Returns: An array containing all elements of the async sequence.
    public func collect() async rethrows -> [Element] {
        try await reduce(into: [Element]()) { $0.append($1) }
    }
}
