import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct NiceThingsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        MemberwiseInitMacro.self,
        URLMacro.self,
    ]
}
