public import Cardinal
public import Tagged

extension Vector.Iterator: IteratorProtocol
where Bound: Copyable {}

extension Vector.Reversed.Iterator: IteratorProtocol
where Bound: Copyable {}

extension Vector where Bound: Copyable {

    @inlinable
    public mutating func removeAll() {
        _clear()
    }
}

extension Vector.Reversed where Bound: Copyable {

    @inlinable
    public mutating func removeAll() {
        _clear()
    }
}

extension Vector: Swift.Sequence where Bound: Copyable {

    @inlinable
    public var underestimatedCount: Int { Int(clamping: count.underlying.rawValue) }
}

extension Vector.Reversed: Swift.Sequence where Bound: Copyable {

    @inlinable
    public var underestimatedCount: Int { Int(clamping: count.underlying.rawValue) }
}
