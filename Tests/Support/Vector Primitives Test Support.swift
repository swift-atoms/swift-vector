import Index_Primitives_Test_Support
public import Vector_Primitives

extension Vector where Bound == UInt {

    public init(
        _ range: Swift.Range<UInt>,
        transform: @escaping @Sendable (UInt) -> UInt = { $0 }
    ) {

        self.init(
            __unchecked: (),
            start: Vector<UInt>.Index(_unchecked: Ordinal(range.lowerBound)),
            end: Vector<UInt>.Index(_unchecked: Ordinal(range.upperBound)),
            transform: { transform($0.position.rawValue) }
        )
    }

    #if !hasFeature(Embedded)

    @inlinable
    public init(
        count: Vector<UInt>.Index.Count,
        transform: @escaping @Sendable (Int) -> Bound = { $0.magnitude }
    ) {
        self.init(count: count, transform: { $0.position.rawValue })
    }

    public init(
        start: Vector<UInt>.Index,
        end: Vector<UInt>.Index,
        transform: @escaping @Sendable (Int) -> Bound = { $0.magnitude }
    ) throws(Vector<UInt>.Error) {
        try self.init(start: start, end: end, transform: { $0.position.rawValue })
    }
    #endif
}

public enum VectorTestError: Swift.Error {

    case countOverflow
}

extension Vector where Bound == Int {

    public init(
        _ range: Swift.Range<Swift.Int>,
        transform: @escaping @Sendable (Swift.Int) -> Swift.Int = { $0 }
    ) throws(VectorTestError) {

        let distance = range.upperBound - range.lowerBound

        guard distance >= .zero, UInt(bitPattern: distance) <= UInt.max else {
            throw .countOverflow
        }
        let count = UInt(distance)

        let offset = range.lowerBound

        self.init(
            __unchecked: (),
            start: Vector<Int>.Index(_unchecked: .zero),
            end: Vector<Int>.Index(_unchecked: Ordinal(count)),
            transform: { transform(offset + Swift.Int(bitPattern: $0)) }
        )
    }
}
