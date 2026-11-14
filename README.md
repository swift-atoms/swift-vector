# swift-vector

Use this package when you need a fixed-dimension tuple of scalars stored inline, with the dimension `N` checked at compile time, and componentwise arithmetic, dot product, length, direction, cross product, interpolation, coding and traversal on it. Start from `Vector<N, Scalar>`. When the tuple means a position, a difference between positions, or a coordinate, use swift-point, swift-displacement or swift-coordinate instead: they wrap a `Vector<N, Scalar>` and give it that meaning.

## Laws

- `+`, `-`, `zero`, `scaled(by:)`, `==` and `map` act componentwise. `zero` is the additive identity. For finite components, `v - v == .zero` and `v.scaled(by: 2) == v + v`.
- `dot` accumulates from `.zero` in index order 0 to `N - 1`, so floating-point rounding follows that order. It distributes over `+` when `Scalar` arithmetic is exact, as for integers that do not overflow.
- For floating-point scalars, `length` is the square root of `v.dot(v)`, and `v.dot(v)` is the squared length. `try v.normalized` is the vector of length one in the same direction, up to rounding; it throws `Vector.Error.zero` for the zero vector and `Vector.Error.nonfinite` when a component is infinite or NaN. It divides by the largest component magnitude before taking the length, so very small and very large vectors normalise without underflow or overflow.
- For 3-vectors over signed scalars, `a.cross(b)` is the right-handed cross product: perpendicular to `a` and `b`, `a.cross(b) + b.cross(a) == .zero`, and `x.cross(y) == z` for the basis vectors.
- `a.interpolated(to: b, at: share)` is `a · (1 − share) + b · share` in every component: a share of 0 gives `a` and a share of 1 gives `b` exactly for finite components, and shares outside 0 to 1 extrapolate along the same line.
- `map` calls its transform in index order and stops at the first thrown error, so later components are not visited. A `Vector<0, Scalar>` never calls the transform.
- Encoding writes an unkeyed list of the `N` components in index order. Decoding fails when the input is not a list, when a component fails to decode, or when the list holds more or fewer than `N` components, including any non-empty list for `N == 0`.
- `Vector<N, Scalar>.Iterator` yields components in index order, and `reversed()` yields them from `N - 1` down to 0. Under the `Sequence` trait, `Sequenceable` operations on `Vector<N, Scalar>` and `Vector<N, Scalar>.Reversed` follow the same orders.
- Under the `Shear` trait, `Shear<N, Scalar>.applied(to:)` changes only the target component, to `target + factor * source`. It fails when any input component is infinite or NaN, including components the shear does not touch, and when the new target value is not finite.
