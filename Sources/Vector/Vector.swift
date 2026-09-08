public struct Vector<let N: Int, Scalar> {
    public var components: InlineArray<N, Scalar>

    public init(_ components: consuming InlineArray<N, Scalar>) {
        self.components = components
    }
}

extension Vector: Swift.Sendable where Scalar: Swift.Sendable {}

extension Vector {
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

extension Vector where Scalar: Numeric {
    public func scaled(by factor: Scalar) -> Self { map { $0 * factor } }

    public func dot(_ other: Self) -> Scalar {
        var result: Scalar = .zero
        for i in 0..<N { result += self[i] * other[i] }
        return result
    }
}
