//
//  EitherTests.swift
//  swift-nice-things
//
//  Created by Jesse Tipton on 4/5/26.
//

import Testing
@testable import NiceThings

struct EitherTests {
    // MARK: - Accessors

    @Test
    func leftAccessorReturnsValueForLeftCase() {
        let either: Either<String, Int> = .left("hello")
        #expect(either.left == "hello")
    }

    @Test
    func leftAccessorReturnsNilForRightCase() {
        let either: Either<String, Int> = .right(42)
        #expect(either.left == nil)
    }

    @Test
    func rightAccessorReturnsValueForRightCase() {
        let either: Either<String, Int> = .right(42)
        #expect(either.right == 42)
    }

    @Test
    func rightAccessorReturnsNilForLeftCase() {
        let either: Either<String, Int> = .left("hello")
        #expect(either.right == nil)
    }

    // MARK: - Map

    @Test
    func mapTransformsLeftValue() {
        let either: Either<String, Int> = .left("hello")
        let result = either.map(left: { $0.count }, right: { $0 * 2 })
        #expect(result == .left(5))
    }

    @Test
    func mapTransformsRightValue() {
        let either: Either<String, Int> = .right(21)
        let result = either.map(left: { $0.count }, right: { $0 * 2 })
        #expect(result == .right(42))
    }

    // MARK: - Map Left

    @Test
    func mapLeftTransformsLeftValue() {
        let either: Either<String, Int> = .left("hello")
        let mapped = either.mapLeft { $0.uppercased() }
        #expect(mapped == .left("HELLO"))
    }

    @Test
    func mapLeftPreservesRightValue() {
        let either: Either<String, Int> = .right(42)
        let mapped = either.mapLeft { $0.uppercased() }
        #expect(mapped == .right(42))
    }

    // MARK: - Map Right

    @Test
    func mapRightTransformsRightValue() {
        let either: Either<String, Int> = .right(21)
        let mapped = either.mapRight { $0 * 2 }
        #expect(mapped == .right(42))
    }

    @Test
    func mapRightPreservesLeftValue() {
        let either: Either<String, Int> = .left("hello")
        let mapped = either.mapRight { $0 * 2 }
        #expect(mapped == .left("hello"))
    }

    // MARK: - Flat Map Left

    @Test
    func flatMapLeftTransformsLeftValue() {
        let either: Either<String, Int> = .left("hello")
        let result = either.flatMapLeft { .left($0.count) }
        #expect(result == Either<Int, Int>.left(5))
    }

    @Test
    func flatMapLeftCanReturnRight() {
        let either: Either<String, Int> = .left("")
        let result = either.flatMapLeft { value -> Either<String, Int> in
            value.isEmpty ? .right(0) : .left(value)
        }
        #expect(result == .right(0))
    }

    @Test
    func flatMapLeftPreservesRightValue() {
        let either: Either<String, Int> = .right(42)
        let result = either.flatMapLeft { Either<Int, Int>.left($0.count) }
        #expect(result == .right(42))
    }

    // MARK: - Flat Map Right

    @Test
    func flatMapRightTransformsRightValue() {
        let either: Either<String, Int> = .right(42)
        let result = either.flatMapRight { .right(String($0)) }
        #expect(result == Either<String, String>.right("42"))
    }

    @Test
    func flatMapRightCanReturnLeft() {
        let either: Either<String, Int> = .right(-1)
        let result = either.flatMapRight { value -> Either<String, Int> in
            value < 0 ? .left("negative") : .right(value)
        }
        #expect(result == .left("negative"))
    }

    @Test
    func flatMapRightPreservesLeftValue() {
        let either: Either<String, Int> = .left("error")
        let result = either.flatMapRight { Either<String, String>.right(String($0)) }
        #expect(result == .left("error"))
    }

    // MARK: - Fold

    @Test
    func foldCollapsesLeftValue() {
        let either: Either<String, Int> = .left("hello")
        let result = either.fold(left: { $0.count }, right: { $0 })
        #expect(result == 5)
    }

    @Test
    func foldCollapsesRightValue() {
        let either: Either<String, Int> = .right(42)
        let result = either.fold(left: { $0.count }, right: { $0 })
        #expect(result == 42)
    }

    // MARK: - Equatable

    @Test
    func equalLeftValues() {
        let a: Either<String, Int> = .left("hello")
        let b: Either<String, Int> = .left("hello")
        #expect(a == b)
    }

    @Test
    func unequalLeftValues() {
        let a: Either<String, Int> = .left("hello")
        let b: Either<String, Int> = .left("world")
        #expect(a != b)
    }

    @Test
    func leftNotEqualToRight() {
        let a: Either<Int, Int> = .left(1)
        let b: Either<Int, Int> = .right(1)
        #expect(a != b)
    }

    // MARK: - CustomStringConvertible

    @Test
    func descriptionForLeft() {
        let either: Either<String, Int> = .left("hello")
        #expect(either.description == "left(hello)")
    }

    @Test
    func descriptionForRight() {
        let either: Either<String, Int> = .right(42)
        #expect(either.description == "right(42)")
    }

    // MARK: - CustomDebugStringConvertible

    @Test
    func debugDescriptionForLeft() {
        let either: Either<String, Int> = .left("hello")
        #expect(either.debugDescription == "Either<String, Int>.left(\"hello\")")
    }

    @Test
    func debugDescriptionForRight() {
        let either: Either<String, Int> = .right(42)
        #expect(either.debugDescription == "Either<String, Int>.right(42)")
    }
}
