import AssociatedObjects
import Foundation

#if canImport(ObjectiveC)
@attached(accessor)
public macro AssociatedObject(
	policy: objc_AssociationPolicy,
	readonly: Bool
) = #externalMacro(
	module: "AssociatedObjectsMacrosPlugin",
	type: "AssociatedObjectMacro"
)

@attached(accessor)
public macro AssociatedObject(
	threadSafety: _AssociationPolicyThreadSafety = .nonatomic,
	readonly: Bool = true
) = #externalMacro(
	module: "AssociatedObjectsMacrosPlugin",
	type: "AssociatedObjectMacro"
)
#endif
