/// Generates a public memberwise initializer for the attached type.
///
/// This macro creates an initializer that accepts parameters for all stored properties,
/// similar to Swift's auto-synthesized memberwise initializer, but with `public` access.
///
/// - Warning: Applying this macro to non-public types will emit a warning,
///   since Swift already synthesizes a memberwise initializer for internal types.
///
/// ## Example
///
/// ```swift
/// @MemberwiseInit
/// public struct User {
///     let id: Int
///     let name: String
///     var isActive: Bool = true
/// }
/// ```
///
/// Expands to:
///
/// ```swift
/// public struct User {
///     let id: Int
///     let name: String
///     var isActive: Bool = true
///
///     public init(id: Int, name: String, isActive: Bool = true) {
///         self.id = id
///         self.name = name
///         self.isActive = isActive
///     }
/// }
/// ```
@attached(member, names: named(init))
public macro MemberwiseInit() = #externalMacro(module: "NiceThingsMacros", type: "MemberwiseInitMacro")
