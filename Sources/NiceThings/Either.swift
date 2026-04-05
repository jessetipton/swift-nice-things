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

// MARK: - Accessors

extension Either {
    /// The left value, if this instance is `.left`; otherwise, `nil`.
    public var left: Left? {
        switch self {
        case .left(let value): value
        case .right: nil
        }
    }

    /// The right value, if this instance is `.right`; otherwise, `nil`.
    public var right: Right? {
        switch self {
        case .left: nil
        case .right(let value): value
        }
    }

}

// MARK: - Transforms

extension Either {
    /// Returns a new `Either` with both sides transformed by the appropriate closure.
    public func map<NewLeft, NewRight>(
        left transformLeft: (Left) throws -> NewLeft,
        right transformRight: (Right) throws -> NewRight
    ) rethrows -> Either<NewLeft, NewRight> {
        switch self {
        case .left(let value):
            .left(try transformLeft(value))
        case .right(let value):
            .right(try transformRight(value))
        }
    }

    /// Returns a new `Either` with the left value transformed by `transform`,
    /// leaving a `.right` unchanged.
    public func mapLeft<NewLeft>(
        _ transform: (Left) throws -> NewLeft
    ) rethrows -> Either<NewLeft, Right> {
        switch self {
        case .left(let value):
            .left(try transform(value))
        case .right(let value):
            .right(value)
        }
    }

    /// Returns a new `Either` with the right value transformed by `transform`,
    /// leaving a `.left` unchanged.
    public func mapRight<NewRight>(
        _ transform: (Right) throws -> NewRight
    ) rethrows -> Either<Left, NewRight> {
        switch self {
        case .left(let value):
            .left(value)
        case .right(let value):
            .right(try transform(value))
        }
    }

    /// Returns the result of applying `transform` to the left value if this is `.left`,
    /// or re-wraps the right value if this is `.right`.
    public func flatMapLeft<NewLeft>(
        _ transform: (Left) throws -> Either<NewLeft, Right>
    ) rethrows -> Either<NewLeft, Right> {
        switch self {
        case .left(let value):
            try transform(value)
        case .right(let value):
            .right(value)
        }
    }

    /// Returns the result of applying `transform` to the right value if this is `.right`,
    /// or re-wraps the left value if this is `.left`.
    public func flatMapRight<NewRight>(
        _ transform: (Right) throws -> Either<Left, NewRight>
    ) rethrows -> Either<Left, NewRight> {
        switch self {
        case .left(let value):
            .left(value)
        case .right(let value):
            try transform(value)
        }
    }
}

// MARK: - Elimination

extension Either {
    /// Collapses this `Either` into a single value by applying the appropriate closure.
    public func fold<Result>(
        left: (Left) throws -> Result,
        right: (Right) throws -> Result
    ) rethrows -> Result {
        switch self {
        case .left(let value):
            try left(value)
        case .right(let value):
            try right(value)
        }
    }
}

// MARK: - Conditional Conformances

extension Either: Equatable where Left: Equatable, Right: Equatable {}

extension Either: Hashable where Left: Hashable, Right: Hashable {}

extension Either: Sendable where Left: Sendable, Right: Sendable {}


extension Either: CustomStringConvertible {
    public var description: String {
        switch self {
        case .left(let value):
            "left(\(value))"
        case .right(let value):
            "right(\(value))"
        }
    }
}

extension Either: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .left(let value):
            "Either<\(Left.self), \(Right.self)>.left(\(String(reflecting: value)))"
        case .right(let value):
            "Either<\(Left.self), \(Right.self)>.right(\(String(reflecting: value)))"
        }
    }
}
