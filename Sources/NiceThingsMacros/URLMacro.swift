import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

public struct URLMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression,
              let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
              segments.count == 1,
              case .stringSegment(let literalSegment)? = segments.first
        else {
            throw URLMacroError.requiresStaticStringLiteral
        }

        let urlString = literalSegment.content.text

        guard URL(string: urlString) != nil else {
            throw URLMacroError.malformedURL(urlString)
        }

        return "URL(string: \(argument))!"
    }
}

enum URLMacroError: Error, CustomStringConvertible {
    case requiresStaticStringLiteral
    case malformedURL(String)

    var description: String {
        switch self {
        case .requiresStaticStringLiteral:
            return "#URL requires a static string literal"
        case .malformedURL(let urlString):
            return "malformed URL: \"\(urlString)\""
        }
    }
}
