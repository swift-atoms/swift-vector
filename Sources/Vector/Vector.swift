/// A fixed-dimensional mathematical vector. Its dimension is part of its type.
/// Component arithmetic follows the scalar's semantics, including overflow.
public struct Vector<let N: Int, Scalar> {
    public var components: InlineArray<N, Scalar>

    public init(_ components: consuming InlineArray<N, Scalar>) {
        self.components = components
    }

    public init(repeating value: Scalar) {
        self.components = InlineArray(repeating: value)
    }

    public subscript(index: Int) -> Scalar {
        get { components[index] }
        set { components[index] = newValue }
    }

    public func map<Result>(_ transform: (Scalar) throws -> Result) rethrows -> Vector<N, Result> {
        try Vector<N, Result>(InlineArray { try transform(components[$0]) })
    }
}

extension Vector: Sendable where Scalar: Sendable {}

extension Vector: Equatable where Scalar: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        for i in 0..<N where lhs[i] != rhs[i] { return false }
        return true
    }
}

extension Vector: Hashable where Scalar: Hashable {
    public func hash(into hasher: inout Hasher) {
        for i in 0..<N { hasher.combine(self[i]) }
    }
}

extension Vector: AdditiveArithmetic where Scalar: AdditiveArithmetic {
    public static var zero: Self { Self(repeating: .zero) }
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(InlineArray { lhs[$0] + rhs[$0] })
    }
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(InlineArray { lhs[$0] - rhs[$0] })
    }
}

extension Vector where Scalar: Numeric {
    public func scaled(by factor: Scalar) -> Self { map { $0 * factor } }

    public func dot(_ other: Self) -> Scalar {
        var result: Scalar = .zero
        for i in 0..<N { result += self[i] * other[i] }
        return result
    }
}
