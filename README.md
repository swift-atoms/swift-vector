# swift-vector

Use this package when you need a fixed-dimension tuple of scalars stored inline, with the dimension `N` checked at compile time, and componentwise arithmetic, dot product, coding and traversal on it. Start from `Vector<N, Scalar>`. When the tuple means a position, a difference between positions, or a coordinate, use swift-point, swift-displacement or swift-coordinate instead: they wrap a `Vector<N, Scalar>` and give it that meaning.

## Laws

- `+`, `-`, `zero`, `scaled(by:)`, `==` and `map` act componentwise. `zero` is the additive identity, `v - v == .zero`, and `v.scaled(by: 2) == v + v`.
- `dot` accumulates from `.zero` in index order 0 to `N - 1`, so floating-point rounding follows that order. It distributes over `+`.
- `map` calls its transform in index order and stops at the first thrown error, so later components are not visited. A `Vector<0, Scalar>` never calls the transform.
- Encoding writes an unkeyed list of the `N` components in index order. Decoding fails when the input is not a list, when a component fails to decode, or when the list holds more or fewer than `N` components, including any non-empty list for `N == 0`.
- `Vector<N, Scalar>.Iterator` yields components in index order, and `reversed()` yields them from `N - 1` down to 0. Under the `Sequence` trait, `Sequenceable` operations on `Vector<N, Scalar>` and `Vector<N, Scalar>.Reversed` follow the same orders.
- Under the `Shear` trait, `Shear<N, Scalar>.applied(to:)` changes only the target component, to `target + factor * source`. It fails when any input component is infinite or NaN, including components the shear does not touch, and when the new target value is not finite.
