# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Project Overview

A Swift package providing utility extensions and Swift macros for Apple platforms. Uses Swift 6 language mode with strict concurrency.

## Build & Test Commands

```bash
swift build          # Build the package
swift test           # Run all tests
swift test --filter NiceThingsTests          # Run library tests only
swift test --filter NiceThingsMacrosTests    # Run macro tests only
swift test --filter NiceThingsMacrosTests.URLMacroTests  # Run a single test suite
```

## Architecture

The package has two main targets:

- **NiceThings** — The public library target. Contains utility extensions (on `Collection`, `Sequence`, `AsyncSequence`, SwiftUI types) and macro declarations. Extensions are organized under `Sources/NiceThings/Extensions/` by framework.
- **NiceThingsMacros** — A Swift macro plugin (compiler plugin). Contains macro implementations that expand at compile time. Registered in `NiceThingsPlugin.swift`.

Macro declarations (the `public macro` signatures) live in `NiceThings`, while their implementations live in `NiceThingsMacros`. This is the standard SwiftSyntax macro split.

### Current Macros

- `@MemberwiseInit` — Attached member macro generating a public memberwise initializer
- `#URL` — Freestanding expression macro for compile-time URL validation

### Documentation

DocC documentation is hosted on [Swift Package Index](https://swiftpackageindex.com/jessetipton/swift-nice-things/documentation/nicethings). The `.spi.yml` file at the repo root configures SPI to build docs for the `NiceThings` target.

When adding or changing public API:

- Add [DocC-formatted](https://www.swift.org/documentation/docc/) doc comments to all new public symbols
- Update topic groups in `Sources/NiceThings/NiceThings.docc/NiceThings.md` so new symbols appear on the landing page

### Testing

- Library tests use Swift Testing (`@Suite`, `@Test`)
- Macro tests use `assertMacro` from [swift-macro-testing](https://github.com/pointfreeco/swift-macro-testing), which snapshot-tests macro expansions and diagnostics
