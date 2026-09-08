#if !hasFeature(Embedded)
extension Vector: Encodable where Scalar: Encodable {
    /// Encode components in axis order, without introducing another container.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        for index in 0..<N {
            try container.encode(components[index])
        }
    }
}

extension Vector: Decodable where Scalar: Decodable {
    /// A vector's encoded dimension must match its statically declared dimension.
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let count = container.count, count != N {
            throw DecodingError.dataCorruptedError(
                in: container, debugDescription: "Expected exactly \(N) vector components"
            )
        }
        let components: InlineArray<N, Scalar> = try InlineArray { _ in
            try container.decode(Scalar.self)
        }
        guard container.isAtEnd else {
            throw DecodingError.dataCorruptedError(
                in: container, debugDescription: "Expected exactly \(N) vector components"
            )
        }
        self.init(components)
    }
}
#endif
