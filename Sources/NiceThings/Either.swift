//
//  Either.swift
//  swift-nice-things
//
//  Created by Jesse Tipton on 2/9/25.
//

public enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

extension Either: Hashable where Left: Hashable, Right: Hashable {}

extension Either: Equatable where Left: Equatable, Right: Equatable {}

extension Either: Sendable where Left: Sendable, Right: Sendable {}
