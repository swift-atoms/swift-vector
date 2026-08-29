public import Index
public import Ordinal
public import Ordinal_Cardinal
public import Ordinal_Protocol
public import Tagged

@inlinable
public func ..< <Tag: ~Copyable & ~Escapable>(
    lhs: Index<Tag>,
    rhs: Index<Tag>.Count
) -> Vector<Index<Tag>> {
    let start: Vector<Index<Tag>>.Index = lhs.retag()
    let end: Vector<Index<Tag>>.Index = rhs.map { Ordinal::Ordinal($0) }.retag()

    return Vector(
        __unchecked: (),
        start: start,
        end: end,
        transform: { $0.retag() }
    )
}
