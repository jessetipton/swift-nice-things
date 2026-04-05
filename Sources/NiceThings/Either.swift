//
//  Either.swift
//  swift-nice-things
//
//  Created by Jesse Tipton on 2/9/25.
//

/// A simple discriminated union that holds a value of either type `Left` or type `Right`.
///
/// `Either` is useful when a value can be one of two distinct types. It conditionally conforms
/// to `Equatable`, `Hashable`, and `Sendable` when both `Left` and `Right` conform.
///
/// ## Example
///
/// ```swift
/// let value: Either<String, Int> = .left("hello")
///
/// switch value {
/// case .left(let string):
///     print(string)
/// case .right(let number):
///     print(number)
/// }
/// ```
public enum Either<Left, Right> {
    /// The first possible value, containing an instance of `Left`.
    case left(Left)
    /// The second possible value, containing an instance of `Right`.
    case right(Right)
}

extension Either: Hashable where Left: Hashable, Right: Hashable {}

extension Either: Equatable where Left: Equatable, Right: Equatable {}

extension Either: Sendable where Left: Sendable, Right: Sendable {}
