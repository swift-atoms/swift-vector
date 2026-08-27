internal import Ordinal
@_spi(Internal) internal import Tagged
public import Vector

extension Vector where Bound == UInt {
    public init(
        _ range: Swift.Range<UInt>,
        transform: @escaping @Sendable (UInt) -> UInt = { $0 }
    ) {
        self.init(count: range.upperBound - range.lowerBound) { index in
            transform(range.lowerBound + index.underlying.rawValue)
        }
    }
}

extension Vector where Bound == Int {
    public init(
        _ range: Swift.Range<Int>,
        transform: @escaping @Sendable (Int) -> Int = { $0 }
    ) {
        let lower = UInt(bitPattern: range.lowerBound)
        let upper = UInt(bitPattern: range.upperBound)
        self.init(count: upper &- lower) { index in
            transform(Int(bitPattern: lower &+ index.underlying.rawValue))
        }
    }
}
