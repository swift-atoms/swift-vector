public import Affine_Arithmetic
public import Affine_Tagged
public import Index
public import Ordinal
public import Ordinal_Error
public import Ordinal_Predecessor
public import Ordinal_Protocol
public import Tagged

extension Vector {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(
        _ range: Swift.Range<Index::Index<Tag>>
    ) where Bound == Index::Index<Tag> {
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
    public subscript<Tag: ~Copyable & ~Escapable>(offset: Index::Index<Tag>.Offset)
        -> Index::Index<Tag>
    where Bound == Index::Index<Tag> {
        let vectorOffset: Vector<Bound>.Index.Offset = offset.retag()
        precondition(vectorOffset < count, "Offset out of bounds")

        let position: Vector<Bound>.Index
        do throws(Ordinal::Ordinal.Error) {
            position = try start + vectorOffset
        } catch {
            fatalError("invariant violation: \(error)")
        }
        return transform(position)
    }
}

extension Vector.Reversed {

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(offset: Index::Index<Tag>.Offset)
        -> Index::Index<Tag>
    where Bound == Index::Index<Tag> {
        let vectorOffset: Vector<Bound>.Index.Offset = offset.retag()
        precondition(vectorOffset < count, "Offset out of bounds")

        let position: Vector<Bound>.Index
        do throws(Ordinal::Ordinal.Error) {
            let lastIndex = try end.predecessor.exact()
            position = try lastIndex - vectorOffset
        } catch {
            fatalError("invariant violation: \(error)")
        }
        return transform(position)
    }
}
