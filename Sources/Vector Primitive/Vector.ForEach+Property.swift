public import Property_Primitives

extension Property {

    @inlinable
    public func callAsFunction<Bound: ~Copyable, E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) where Tag == Vector<Bound>.ForEach, Base == Vector<Bound> {
        var copy = base
        try copy._borrowingForEach(body)
    }

    @inlinable
    public func borrowing<Bound: ~Copyable, E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) where Tag == Vector<Bound>.ForEach, Base == Vector<Bound> {
        var copy = base
        try copy._borrowingForEach(body)
    }

    @inlinable
    public func callAsFunction<Bound: ~Copyable, E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) where Tag == Vector<Bound>.ForEach, Base == Vector<Bound>.Reversed {
        var copy = base
        try copy._borrowingForEach(body)
    }

    @inlinable
    public func borrowing<Bound: ~Copyable, E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) where Tag == Vector<Bound>.ForEach, Base == Vector<Bound>.Reversed {
        var copy = base
        try copy._borrowingForEach(body)
    }
}
