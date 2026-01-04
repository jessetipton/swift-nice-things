import MacroTesting
import Testing

@testable import NiceThingsMacros

@Suite
struct MemberwiseInitMacroTests {
    @Test
    func publicStructWithMultipleProperties() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public struct User {
                let id: Int
                let name: String
                var email: String
            }
            """
        } expansion: {
            """
            public struct User {
                let id: Int
                let name: String
                var email: String

                public init(id: Int, name: String, email: String) {
                    self.id = id
                    self.name = name
                    self.email = email
                }
            }
            """
        }
    }

    @Test
    func publicStructWithDefaultValues() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public struct Settings {
                var theme: String = "light"
                var fontSize: Int = 14
                let isEnabled: Bool
            }
            """
        } expansion: {
            """
            public struct Settings {
                var theme: String = "light"
                var fontSize: Int = 14
                let isEnabled: Bool

                public init(theme: String = "light", fontSize: Int = 14, isEnabled: Bool) {
                    self.theme = theme
                    self.fontSize = fontSize
                    self.isEnabled = isEnabled
                }
            }
            """
        }
    }

    @Test
    func nonPublicStructEmitsWarning() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            struct InternalUser {
                let id: Int
                let name: String
            }
            """
        } diagnostics: {
            """
            @MemberwiseInit
            ┬──────────────
            ╰─ ⚠️ @MemberwiseInit is pointless on non-public types; Swift already synthesizes a memberwise initializer
            struct InternalUser {
                let id: Int
                let name: String
            }
            """
        } expansion: {
            """
            struct InternalUser {
                let id: Int
                let name: String

                public init(id: Int, name: String) {
                    self.id = id
                    self.name = name
                }
            }
            """
        }
    }

    @Test
    func ignoresComputedProperties() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public struct Rectangle {
                let width: Double
                let height: Double
                var area: Double {
                    width * height
                }
            }
            """
        } expansion: {
            """
            public struct Rectangle {
                let width: Double
                let height: Double
                var area: Double {
                    width * height
                }

                public init(width: Double, height: Double) {
                    self.width = width
                    self.height = height
                }
            }
            """
        }
    }

    @Test
    func ignoresStaticProperties() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public struct Config {
                static let version: String = "1.0"
                let apiKey: String
                var timeout: Int
            }
            """
        } expansion: {
            """
            public struct Config {
                static let version: String = "1.0"
                let apiKey: String
                var timeout: Int

                public init(apiKey: String, timeout: Int) {
                    self.apiKey = apiKey
                    self.timeout = timeout
                }
            }
            """
        }
    }

    @Test
    func handlesPropertyWithDidSet() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public struct Counter {
                var count: Int {
                    didSet { print(count) }
                }
            }
            """
        } expansion: {
            """
            public struct Counter {
                var count: Int {
                    didSet { print(count) }
                }

                public init(count: Int) {
                    self.count = count
                }
            }
            """
        }
    }

    @Test
    func handlesPropertyWithWillSet() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public struct Observable {
                var value: String {
                    willSet { print(newValue) }
                }
            }
            """
        } expansion: {
            """
            public struct Observable {
                var value: String {
                    willSet { print(newValue) }
                }

                public init(value: String) {
                    self.value = value
                }
            }
            """
        }
    }

    @Test
    func publicClass() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public class Person {
                let name: String
                var age: Int
            }
            """
        } expansion: {
            """
            public class Person {
                let name: String
                var age: Int

                public init(name: String, age: Int) {
                    self.name = name
                    self.age = age
                }
            }
            """
        }
    }

    @Test
    func emptyStruct() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public struct Empty {
            }
            """
        } expansion: {
            """
            public struct Empty {
            }
            """
        }
    }

    @Test
    func structWithOnlyComputedProperties() {
        assertMacro(["MemberwiseInit": MemberwiseInitMacro.self]) {
            """
            @MemberwiseInit
            public struct Computed {
                var value: Int {
                    42
                }
            }
            """
        } expansion: {
            """
            public struct Computed {
                var value: Int {
                    42
                }
            }
            """
        }
    }
}
