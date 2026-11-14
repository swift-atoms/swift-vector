extension Vector where Scalar: FloatingPoint {

    /// The Euclidean length: the square root of `dot(self)`, which is the squared length.
    @inlinable
    public var length: Scalar {
        dot(self).squareRoot()
    }

    /// The vector of length one in the same direction, up to rounding.
    ///
    /// It throws `Error.zero` for the zero vector, which has no direction, and `Error.nonfinite`
    /// when a component is infinite or NaN. The components are divided by the largest magnitude
    /// before the length is taken, so very small and very large vectors normalise without
    /// underflow or overflow.
    @inlinable
    public var normalized: Self {
        get throws(Error) {
            var finite = true
            var largest: Scalar = .zero
            (0..<N).forEach { index in
                finite = finite && self[index].isFinite
                largest = Swift.max(largest, self[index].magnitude)
            }
            guard finite else { throw .nonfinite }
            guard largest > .zero else { throw .zero }
            let reduced = Self(InlineArray { self[$0] / largest })
            let length = reduced.length
            return Self(InlineArray { reduced[$0] / length })
        }
    }

    /// The vector a share of the way from this vector to another: `self · (1 − share) + other · share`
    /// in every component, so a share of 0 gives this vector and a share of 1 the other exactly, for
    /// finite components. Shares outside 0 to 1 continue along the same line.
    @inlinable
    public func interpolated(to other: Self, at share: Scalar) -> Self {
        Self(InlineArray { self[$0] * (1 - share) + other[$0] * share })
    }
}
