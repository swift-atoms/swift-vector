# Vector

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

`Vector<Bound>` is a lazy half-open generator over typed
`Index<Vector<Bound>>` positions. It keeps typed start and end positions, uses
`UInt` for local cardinality, and produces each bound on demand without
allocating backing storage.

---

## Quick Start

```swift
import Vector

let repeated = Vector<String>(count: 3) { _ in "value" }

repeated.forEach { value in
    print(value)
}

var consumable = repeated
consumable.drain { value in
    print(value)
}

let head = repeated.prefix.first(2)
let tail = repeated.drop.first(1)
let reversed = repeated.reversed()
```

`Vector Test Support` adds convenient `Range<Int>` and `Range<UInt>` fixtures
for tests.

---

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-atoms/swift-vector.git", branch: "main"),
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Vector", package: "swift-vector"),
    ]
)
```

The package is pre-1.0. It requires Swift 6.4 and macOS 27, iOS 27, tvOS 27,
watchOS 27, or visionOS 27, with matching Linux and Windows toolchains.

---

## Architecture

Three library products. Foundation is confined to the AFI target.

| Product | When to import | What's in it |
|---------|---------------|--------------|
| `Vector` | Default application code | Typed positions, lazy generation, iteration, draining, reversal, prefix, and drop views. |
| `Vector Apple Foundation Integration` | Apple clients that need Foundation | Re-exports the core and Foundation. |
| `Vector Test Support` | Test targets | Range-based fixtures and the core re-export. |

---

## Platform Support

| Platform | CI | Status |
|----------|-----|--------|
| macOS 27 | Yes | Full support |
| iOS / tvOS / watchOS / visionOS | — | Supported |
| Linux | Yes | Full support |
| Windows | Yes | Full support |

---

## Stability

Pre-1.0. The public API may change while the package remains on `branch: "main"`; consumers should expect breaking changes to surface in commit messages until the first tag. Once tagged, the package follows institute SemVer: post-1.0 breaking changes ship behind a major bump.

---

## Related Packages

Direct dependencies:

- [swift-index](https://github.com/swift-atoms/swift-index) provides typed index positions.
- [swift-property](https://github.com/swift-atoms/swift-property) provides the tagged `forEach` accessor.

---

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public release.*
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
