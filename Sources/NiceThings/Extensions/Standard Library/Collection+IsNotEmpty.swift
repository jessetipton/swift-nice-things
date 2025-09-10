//
//  Collection+IsNotEmpty.swift
//  swift-nice-things
//
//  Created by Jesse Tipton on 9/6/25.
//

extension Collection {
    /// A Boolean value indicating whether the collection is empty.
    @inlinable
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}
