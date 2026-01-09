# swift-associated-objects

[![Swift 6.2](https://img.shields.io/badge/Swift-6.2-ED523F.svg?style=flat)](https://swift.org/download/) ![Platforms](https://img.shields.io/badge/Platforms-iOS_13_|_macOS_10.15_|_tvOS_14_|_watchOS_7-ED523F.svg?style=flat) [![@capture_context](https://img.shields.io/badge/Contact-@capture__context-1DA1F2.svg?style=flat&logo=twitter)](https://twitter.com/capture_context) 

Associated objects utils

- [Documentation](https://swiftpackageindex.com/CaptureContext/swift-associated-objects/0.5.0/documentation/associatedobjects)
- [Contents](#contents)
  - [Usage](#usage)
- [Installation](#installation)
  - [Basic](#basic)
  - [Recommended](#recommended)
- [Licence](#licence)

## Contents

### Usage

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

You can add swift-associated-objects to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency…**
2. Enter [`"https://github.com/capturecontext/swift-associated-objects.git"`](https://github.com/capturecontext/swift-associated-objects.git) into the package repository URL text field
3. Choose products you need to link them to your project.

### Recommended

If you use SwiftPM for your project, you can add StandardExtensions to your package file.

```swift
.package(
  url: "https://github.com/capturecontext/swift-associated-objects.git", 
  .upToNextMinor(from: "0.1.0")
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



## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
