import Foundation

/// Creates a non-optional `URL` from a static string literal, validated at compile time.
///
/// This macro validates the URL string during compilation. If the string is not a valid URL,
/// a compiler error is emitted.
///
/// ## Example
///
/// ```swift
/// let apple = #URL("https://apple.com")
/// let api = #URL("https://api.example.com/v1/users")
/// ```
///
/// Invalid URLs produce compiler errors:
///
/// ```swift
/// let invalid = #URL("not a url")  // Error: malformed URL: "not a url"
/// ```
///
/// - Parameter string: A static string literal representing the URL.
/// - Returns: A non-optional `URL` instance.
@freestanding(expression)
public macro URL(_ string: String) -> URL = #externalMacro(module: "NiceThingsMacros", type: "URLMacro")
