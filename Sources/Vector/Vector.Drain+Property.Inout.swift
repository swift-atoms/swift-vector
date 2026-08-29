public import Property_Inout

extension Property.Inout where Base: ~Copyable {

    @inlinable
    public mutating func callAsFunction<Bound: ~Copyable>(
        _ body: (consuming Bound) -> Void
    ) where Tag == Vector<Bound>.Drain, Base == Vector<Bound> {
        base.value._consumingDrain(body)
    }

    @inlinable
    public mutating func callAsFunction<Bound: ~Copyable>(
        _ body: (consuming Bound) -> Void
    ) where Tag == Vector<Bound>.Drain, Base == Vector<Bound>.Reversed {
        base.value._consumingDrain(body)
    }
}
