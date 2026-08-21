public import Index_Primitives

extension Vector {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(
        _ range: Swift.Range<Index_Primitives.Index<Tag>>
    ) where Bound == Index_Primitives.Index<Tag> {
        let start: Vector<Bound>.Index = range.lowerBound.retag()
        let end: Vector<Bound>.Index = range.upperBound.retag()

        self.init(
            __unchecked: (),
            start: start,
            end: end,
            transform: { $0.retag() }
        )
    }
}

extension Vector {

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(offset: Index_Primitives.Index<Tag>.Offset)
        -> Index_Primitives.Index<Tag>
    where Bound == Index_Primitives.Index<Tag> {
        let vectorOffset: Vector<Bound>.Index.Offset = offset.retag()
        precondition(vectorOffset < count, "Offset out of bounds")

        let position: Vector<Bound>.Index
        do throws(Ordinal.Error) {
            position = try start + vectorOffset
        } catch {
            fatalError("invariant violation: \(error)")
        }
        return transform(position)
    }
}

extension Vector.Reversed {

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(offset: Index_Primitives.Index<Tag>.Offset)
        -> Index_Primitives.Index<Tag>
    where Bound == Index_Primitives.Index<Tag> {
        let vectorOffset: Vector<Bound>.Index.Offset = offset.retag()
        precondition(vectorOffset < count, "Offset out of bounds")

        let position: Vector<Bound>.Index
        do throws(Ordinal.Error) {
            let lastIndex = try end.predecessor.exact()
            position = try lastIndex - vectorOffset
        } catch {
            fatalError("invariant violation: \(error)")
        }
        return transform(position)
    }
}
