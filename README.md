# Version

A type used for storing a version number containing a major number, and an optional minor and patch number.

A version can be initialized from individual version numbers.
```swift
Version(1, 0, 2)    // 1.0.2
```

The minor and patch numbers are optional.
```swift
Version(1)    // 1
```

A version can also be initialized from a string.
```swift
Version("1.2.3")    // 1.2.3
```

The version can be converted to a string.
```swift
Version(1, 0, 2).string    // "1.0.2"
```

The type also conforms to `Comparable` for comparing version numbers, and `Codable` for encoding and decoding.

## Installation

Version is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it within another Swift package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    // . . .
    dependencies: [
        .package(url: "https://github.com/mattcox/Version.git", branch: "main")
    ],
    // . . .
)
```

If you’d like to use Version within an application on Apple platforms, then use Xcode’s `File > Add Packages...` menu command to add it to your project.

Import Version wherever you’d like to use it:
```swift
import Version
```
