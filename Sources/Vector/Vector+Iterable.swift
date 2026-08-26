public import Iterable
public import Iterator_Chunk
public import Iterator_Primitive
public import Iterator_Witness
public import Vector_Primitive

extension Vector.Iterator: Iterator_Primitive.Iterator.`Protocol`, IteratorProtocol
where Bound: Copyable {}

extension Vector.Reversed.Iterator: Iterator_Primitive.Iterator.`Protocol`, IteratorProtocol
where Bound: Copyable {}

extension Vector where Bound: Copyable {

    @inlinable
    public borrowing func makeIterator() -> Iterator {
        _makeSequenceIterator()
    }
}

extension Vector.Reversed where Bound: Copyable {

    @inlinable
    public borrowing func makeIterator() -> Iterator {
        _makeSequenceIterator()
    }
}

extension Vector: Iterable where Bound: Copyable {

    public typealias Element = Bound

    @_implements(Iterable,Iterator)
    public typealias IterableIterator = Iterator_Primitive.Iterator.Materializing<
        Iterator_Primitive.Iterator.Witness<Bound, Never>
    >

    @inlinable
    @_lifetime(borrow self)
    @_implements(Iterable,makeIterator())
    public borrowing func iterableMakeIterator()
        -> Iterator_Primitive.Iterator.Materializing<
            Iterator_Primitive.Iterator.Witness<Bound, Never>
        >
    {
        let scalar: Iterator = makeIterator()
        return Iterator_Primitive.Iterator.Materializing(
            Iterator_Primitive.Iterator.Witness(scalar)
        )
    }
}

extension Vector.Reversed: Iterable where Bound: Copyable {

    public typealias Element = Bound

    @_implements(Iterable,Iterator)
    public typealias IterableIterator = Iterator_Primitive.Iterator.Materializing<
        Iterator_Primitive.Iterator.Witness<Bound, Never>
    >

    @inlinable
    @_lifetime(borrow self)
    @_implements(Iterable,makeIterator())
    public borrowing func iterableMakeIterator()
        -> Iterator_Primitive.Iterator.Materializing<
            Iterator_Primitive.Iterator.Witness<Bound, Never>
        >
    {
        let scalar: Iterator = makeIterator()
        return Iterator_Primitive.Iterator.Materializing(
            Iterator_Primitive.Iterator.Witness(scalar)
        )
    }
}

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
    public var underestimatedCount: Int { Int(clamping: count) }
}

extension Vector.Reversed: Swift.Sequence where Bound: Copyable {

    @inlinable
    public var underestimatedCount: Int { Int(clamping: count) }
}
