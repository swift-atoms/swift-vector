extension Vector where N == 3, Scalar: SignedNumeric {

    /// The cross product in a right-handed frame: perpendicular to both vectors, with length
    /// `|self| · |other| · sin θ`. It is anticommutative, `a.cross(b) + b.cross(a) == .zero`,
    /// and the cross product of a vector with itself is zero.
    @inlinable
    public func cross(_ other: Self) -> Self {
        Self([
            self[1] * other[2] - self[2] * other[1],
            self[2] * other[0] - self[0] * other[2],
            self[0] * other[1] - self[1] * other[0],
        ])
    }
}
