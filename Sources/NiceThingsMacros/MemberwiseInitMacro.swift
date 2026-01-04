import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct MemberwiseInitMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let isPublic = declaration.modifiers.contains { modifier in
            modifier.name.tokenKind == .keyword(.public)
        }

        if !isPublic {
            context.diagnose(
                .init(
                    node: node,
                    message: MemberwiseInitDiagnostic.notPublic
                )
            )
        }

        let storedProperties = extractStoredProperties(from: declaration)

        guard !storedProperties.isEmpty else {
            return []
        }

        let parameters = storedProperties.map { property -> String in
            let defaultValue = property.defaultValue.map { " = \($0)" } ?? ""
            return "\(property.name): \(property.type)\(defaultValue)"
        }.joined(separator: ", ")

        let assignments = storedProperties.map { property in
            "self.\(property.name) = \(property.name)"
        }.joined(separator: "\n    ")

        let initDecl: DeclSyntax = """
            public init(\(raw: parameters)) {
                \(raw: assignments)
            }
            """

        return [initDecl]
    }

    private static func extractStoredProperties(
        from declaration: some DeclGroupSyntax
    ) -> [StoredProperty] {
        declaration.memberBlock.members.compactMap { member -> StoredProperty? in
            guard let variable = member.decl.as(VariableDeclSyntax.self),
                  variable.bindingSpecifier.tokenKind == .keyword(.var) ||
                  variable.bindingSpecifier.tokenKind == .keyword(.let),
                  let binding = variable.bindings.first,
                  let identifier = binding.pattern.as(IdentifierPatternSyntax.self),
                  let typeAnnotation = binding.typeAnnotation
            else {
                return nil
            }

            if let accessorBlock = binding.accessorBlock {
                switch accessorBlock.accessors {
                case .getter:
                    // Implicit getter only (e.g., `var value: Int { 42 }`) - computed property
                    return nil
                case .accessors(let accessors):
                    let hasWillSet = accessors.contains { accessor in
                        accessor.accessorSpecifier.tokenKind == .keyword(.willSet)
                    }
                    let hasDidSet = accessors.contains { accessor in
                        accessor.accessorSpecifier.tokenKind == .keyword(.didSet)
                    }
                    // Properties with willSet/didSet are stored properties
                    if hasWillSet || hasDidSet {
                        break
                    }
                    // Other accessor combinations (get, get/set) are computed properties
                    return nil
                }
            }

            let isStatic = variable.modifiers.contains { modifier in
                modifier.name.tokenKind == .keyword(.static) ||
                modifier.name.tokenKind == .keyword(.class)
            }
            if isStatic {
                return nil
            }

            let defaultValue: String?
            if let initializer = binding.initializer {
                defaultValue = initializer.value.description.trimmingCharacters(in: .whitespaces)
            } else {
                defaultValue = nil
            }

            return StoredProperty(
                name: identifier.identifier.text,
                type: typeAnnotation.type.description.trimmingCharacters(in: .whitespaces),
                defaultValue: defaultValue
            )
        }
    }
}

private struct StoredProperty {
    let name: String
    let type: String
    let defaultValue: String?
}

enum MemberwiseInitDiagnostic: String, DiagnosticMessage {
    case notPublic

    var message: String {
        switch self {
        case .notPublic:
            return "@MemberwiseInit is pointless on non-public types; Swift already synthesizes a memberwise initializer"
        }
    }

    var diagnosticID: MessageID {
        MessageID(domain: "NiceThingsMacros", id: rawValue)
    }

    var severity: DiagnosticSeverity {
        switch self {
        case .notPublic:
            return .warning
        }
    }
}

