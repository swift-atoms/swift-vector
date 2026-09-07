extension Vector: Swift.AdditiveArithmetic where Scalar: Swift.AdditiveArithmetic {
    public static var zero: Self { Self(repeating: .zero) }
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(InlineArray { lhs[$0] + rhs[$0] })
    }
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(InlineArray { lhs[$0] - rhs[$0] })
    }
}
