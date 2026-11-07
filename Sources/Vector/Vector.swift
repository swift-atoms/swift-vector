public struct Vector<let N: Int, Scalar> {
    public var components: InlineArray<N, Scalar>

    public init(_ components: consuming InlineArray<N, Scalar>) {
        self.components = components
    }
}

extension Vector: Swift::Sendable where Scalar: Swift::Sendable {}

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
        (0..<N).forEach { i in result += self[i] * other[i] }
        return result
    }
}

#if !hasFeature(Embedded)
    extension Vector: Encodable where Scalar: Encodable {

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.unkeyedContainer()
            for index in 0..<N {
                try container.encode(components[index])
            }
        }
    }

    extension Vector: Decodable where Scalar: Decodable {

        public init(from decoder: any Decoder) throws {
            var container = try decoder.unkeyedContainer()
            if let count = container.count, count != N {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Expected exactly \(N) vector components"
                )
            }
            let components: InlineArray<N, Scalar> = try InlineArray { _ in
                try container.decode(Scalar.self)
            }
            guard container.isAtEnd else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Expected exactly \(N) vector components"
                )
            }
            self.init(components)
        }
    }
#endif

extension Vector: Swift::AdditiveArithmetic where Scalar: Swift::AdditiveArithmetic {
    public static var zero: Self { Self(repeating: .zero) }
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(InlineArray { lhs[$0] + rhs[$0] })
    }
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(InlineArray { lhs[$0] - rhs[$0] })
    }
}

extension Vector: Swift::Equatable where Scalar: Swift::Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        for i in 0..<N where lhs[i] != rhs[i] { return false }
        return true
    }
}

extension Vector: Swift::Hashable where Scalar: Swift::Hashable {
    public func hash(into hasher: inout Hasher) {
        (0..<N).forEach { i in hasher.combine(self[i]) }
    }
}
