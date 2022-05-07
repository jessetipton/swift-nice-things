//
//  Sequence+Sum.swift
//  
//
//  Created by Jesse Tipton on 5/6/22.
//

extension Sequence where Element: Numeric {
    /// The sum of the elements in the sequence.
    public func sum() -> Element {
        return reduce(0, +)
    }
}
