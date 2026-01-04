import MacroTesting
import Testing

@testable import NiceThingsMacros

@Suite
struct URLMacroTests {
    @Test
    func validHTTPSURL() {
        assertMacro(["URL": URLMacro.self]) {
            """
            let url = #URL("https://apple.com")
            """
        } expansion: {
            """
            let url = URL(string: "https://apple.com")!
            """
        }
    }

    @Test
    func validHTTPURL() {
        assertMacro(["URL": URLMacro.self]) {
            """
            let url = #URL("http://example.com/path")
            """
        } expansion: {
            """
            let url = URL(string: "http://example.com/path")!
            """
        }
    }

    @Test
    func validURLWithQueryParameters() {
        assertMacro(["URL": URLMacro.self]) {
            """
            let url = #URL("https://api.example.com/search?q=swift&page=1")
            """
        } expansion: {
            """
            let url = URL(string: "https://api.example.com/search?q=swift&page=1")!
            """
        }
    }

    @Test
    func validFileURL() {
        assertMacro(["URL": URLMacro.self]) {
            """
            let url = #URL("file:///Users/test/file.txt")
            """
        } expansion: {
            """
            let url = URL(string: "file:///Users/test/file.txt")!
            """
        }
    }

    @Test
    func emptyStringEmitsError() {
        assertMacro(["URL": URLMacro.self]) {
            """
            let url = #URL("")
            """
        } diagnostics: {
            """
            let url = #URL("")
                      ┬───────
                      ╰─ 🛑 malformed URL: ""
            """
        }
    }

    @Test
    func stringInterpolationEmitsError() {
        assertMacro(["URL": URLMacro.self]) {
            #"""
            let host = "example.com"
            let url = #URL("https://\(host)")
            """#
        } diagnostics: {
            #"""
            let host = "example.com"
            let url = #URL("https://\(host)")
                      ┬──────────────────────
                      ╰─ 🛑 #URL requires a static string literal
            """#
        }
    }
}
