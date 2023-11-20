//
//  Collection+Average.swift
//
//
//  Created by Jesse Tipton on 11/19/23.
//

import Foundation

extension Collection where Element: FloatingPoint {
    /// The average of the elements in the collection.
    public func average() -> Element {
        return reduce(0, +) / Element(self.count)
    }
}
