# swift-associated-objects

[![CI](https://github.com/capturecontext/swift-associated-objects/actions/workflows/ci.yml/badge.svg)](https://github.com/capturecontext/swift-associated-objects/actions/workflows/ci.yml) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcapturecontext%2Fswift-associated-objects%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/capturecontext/swift-associated-objects) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcapturecontext%2Fswift-associated-objects%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/capturecontext/swift-associated-objects)

Associated objects utils

## Table of contents

- [Documentation](https://swiftpackageindex.com/CaptureContext/swift-associated-objects/0.5.0/documentation/associatedobjects)
- [Usage](#usage)
- [Installation](#installation)
  - [Basic](#basic)
  - [Recommended](#recommended)
- [Licence](#licence)

## Usage

Basic helpers for object association are available in "AssociatedObjects" product

```swift
extension UIViewController {
  var someStoredProperty: Int {
    get { getAssociatedObject(forKey: #function).or(0) }
    set { setAssociatedObject(newValue, forKey: #function)  }
  }
}

let value: Bool = getAssociatedObject(forKey: "value", from: object)
```

But the full power of associated objects is provided by `AssociatedObjectsMacros` target

> By default `@AssociatedObject` macro uses `.retain(.nonatomic)` for classes and `.copy(.nonatomic)` `objc_AssociationPolicy` for structs.

```swift
import AssociatedObjectsMacros

extension SomeClass {
  @AssociatedObject
  var storedVariableInExtension: Int = 0
  
  @AssociatedObject(readonly: true)
  var storedVariableInExtension: SomeObject = .init()
  
  @AssociatedObject
  var optionalValue: Int?
  
  @AssociatedObject
  var object: Int?
    
  @AssociatedObject(threadSafety: .atomic)
  var threadSafeValue: Int?
    
  @AssociatedObject(threadSafety: .atomic)
  var threadSafeObject: Object?
    
  @AssociatedObject(policy: .assign)
  var customPolicyValue: Int?
    
  @AssociatedObject(policy: .retain(.atomic))
  var customPolicyThreadSafeObject: Object?
}
```

> Macros require swift-syntax compilation, so it will affect cold compilation time

## Installation

### Basic

You can add AssociatedObjects to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency…**
2. Enter [`"https://github.com/capturecontext/swift-associated-objects.git"`](https://github.com/capturecontext/swift-associated-objects.git) into the package repository URL text field
3. Choose products you need to link them to your project.

### Recommended

If you use SwiftPM for your project, you can add AssociatedObjects to your package file.

```swift
.package(
  url: "https://github.com/capturecontext/swift-associated-objects.git", 
  .upToNextMinor(from: "0.1.4")
)
```

Do not forget about target dependencies:

```swift
.product(
  name: "AssociatedObjects", 
  package: "swift-associated-objects"
)
```

```swift
.product(
  name: "AssociatedObjectsMacros", 
  package: "swift-associated-objects"
)
```

> [!NOTE]
>
> _The package is compatible with non-Apple platforms, but this package uses conditional compilation, so APIs are only available `#if canImport(ObjectiveC)`_

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
